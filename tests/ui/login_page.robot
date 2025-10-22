*** Settings ***
Resource    ${CURDIR}/../../resources/variables/env_vars.robot
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.robot
Suite Setup    Navigate To Page For Suite    url=${UI_BASE_URL}${LOGIN_PAGE_PATH}

*** Variables ***
${page_header_selector}    heading[name="Login Page"][level=2]
${username_field_selector}    textbox[name="Username"]
${password_field_selector}    textbox[name="Password"]
${login_button_selector}    button

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}    ${timeout}=${GLOBAL_WAIT}
    Fill Text    role=${username_field_selector}    ${username}
    Fill Text    role=${password_field_selector}    ${password}
    Click    role=${login_button_selector}

*** Test Cases ***
Verify Login Page Header
    ${page}=    Set Variable    ${suite_page}
    ${page}=    Handle Page    ${page}
    Wait For Elements State    role=${page_header_selector}    visible    timeout=${GLOBAL_WAIT}

Verify Login Workflow Success
    ${page}=    Set Variable    ${suite_page}
    ${page}=    Handle Page    ${page}
    Login    tomsmith    SuperSecretPassword!
    &{success_banner_locator}    Create Dictionary    type=xpath    selector=//div[@class='flash success']    state=visible
    &{success_header_locator}    Create Dictionary    type=role    selector=heading[name='Secure Area'][level=2]    state=visible
    @{success_locators}    Create List    ${success_banner_locator}    ${success_header_locator}
    Wait For Elements List    @{success_locators}
    Click    xpath=//a[@href='/logout']
    Wait For Elements State    role=${page_header_selector}    visible    timeout=${GLOBAL_WAIT}

Verify Login Failure
    [Tags]    detach_page
    ${page}=    Set Variable    ${suite_page}
    ${page}=    Handle Page    ${page}    ${UI_BASE_URL}${LOGIN_PAGE_PATH}
    Login    fail    fail
    Wait For Elements State    xpath=//div[@class='flash error']    visible    timeout=${GLOBAL_WAIT}
    Breakpoint