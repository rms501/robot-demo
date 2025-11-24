*** Settings ***
Library    Browser
Library    Collections
Resource    ../variables/env_vars.resource

*** Keywords ***
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
    [Arguments]    ${url}    ${timeout}=3s
    ${page}=    Navigate To Page    ${url}    timeout=${timeout}
    Set Suite Variable    ${suite_page}    ${page}