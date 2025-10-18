*** Settings ***
Library    Browser
Library    Collections
Library    DebugLibrary
Resource    ../variables/env_vars.robot

*** Keywords ***
Breakpoint
    Run Keyword If    ${DEBUG_MODE} == True    Debug

Navigate To Page
    [Arguments]    ${url}    ${headless}=True    ${timeout}=3s
    New Browser    headless=${headless}    browser=chromium
    New Context
    New Page       ${url}
    Wait For Load State    domcontentloaded    timeout=${timeout}

Wait For Elements List
    [Arguments]    @{locators}
    FOR    ${locator}    IN    @{locators}
        ${type}=    Get From Dictionary    ${locator}    type
        ${selector}=    Get From Dictionary    ${locator}    selector
        ${state}=    Get From Dictionary    ${locator}    state
        ${timeout}=    Get From Dictionary    ${locator}    timeout    default=${GLOBAL_WAIT}
        &{args}=    Create Dictionary    state=${state}    timeout=${timeout}
        Wait For Elements State    ${type}=${selector}    &{args}
    END