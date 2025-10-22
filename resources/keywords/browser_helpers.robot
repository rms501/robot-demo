*** Settings ***
Library    Browser
Library    Collections
Library    DebugLibrary
Resource    ../variables/env_vars.robot

*** Keywords ***
Breakpoint
    Run Keyword If    ${DEBUG_MODE} == True    Debug

Handle Page
    [Arguments]    ${page}    ${url}=None
    IF    "detach_page" in ${TEST TAGS}
        ${page}=    New Page    ${url}
    END
    RETURN    ${page}

Open New Browser And Context
    [Arguments]    ${headless}=True    ${browser}=chromium
    New Browser    headless=${headless}    browser=${browser}
    New Context

Navigate To Page
    [Arguments]    ${url}    ${timeout}=3s
    ${page}=    New Page       ${url}
    Wait For Load State    domcontentloaded    timeout=${timeout}
    RETURN    ${page}

Navigate To Page For Suite
    [Arguments]    ${url}    ${headless}=True    ${browser}=chromium    ${timeout}=3s
    ${page}=    Navigate To Page    ${url}    timeout=${timeout}
    Set Suite Variable    ${suite_page}    ${page}

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