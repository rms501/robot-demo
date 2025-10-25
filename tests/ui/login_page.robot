*** Settings ***
Resource    ${CURDIR}/../../resources/variables/env_vars.robot
Resource    ${CURDIR}/../../resources/keywords/generic_helpers.robot
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.robot
Test Setup    Navigate To Page    url=${UI_BASE_URL}${LOGIN_PAGE_PATH}
Test Teardown    Close Page

*** Variables ***
${PAGE_HEADER_SELECTOR}    heading[name="Login Page"][level=2]
${USERNAME_FIELD_SELECTOR}    textbox[name="Username"]
${PASSWORD_FIELD_SELECTOR}    textbox[name="Password"]
${LOGIN_BUTTON_SELECTOR}    button
${USERNAME}    tomsmith
${PASSWORD}    SuperSecretPassword!

*** Keywords ***
Login
    [Arguments]    ${username}    ${password}    ${timeout}=${GLOBAL_WAIT}
    Fill Text    role=${USERNAME_FIELD_SELECTOR}    ${username}
    Fill Text    role=${PASSWORD_FIELD_SELECTOR}    ${password}
    Click    role=${LOGIN_BUTTON_SELECTOR}

Login Failure
    [Arguments]    ${username}    ${password}    ${timeout}=${GLOBAL_WAIT}
    Login    username=${username}    password=${password}    timeout=${timeout}
    Wait For Elements State    xpath=//div[@class='flash error']    visible    timeout=${GLOBAL_WAIT}

*** Test Cases ***
Verify Login Page Header
    Wait For Elements State    role=${PAGE_HEADER_SELECTOR}    visible    timeout=${GLOBAL_WAIT}

Verify Login Success
    Login    ${USERNAME}    ${PASSWORD}
    &{success_banner_locator}    Create Dictionary    type=xpath    selector=//div[@class='flash success']    state=visible
    &{success_header_locator}    Create Dictionary    type=role    selector=heading[name='Secure Area'][level=2]    state=visible
    @{success_locators}    Create List    ${success_banner_locator}    ${success_header_locator}
    Wait For Elements List    ${success_locators}
    Click    xpath=//a[@href='/logout']
    Wait For Elements State    role=${page_header_selector}    visible    timeout=${GLOBAL_WAIT}

Verify Login Failure
    [Template]    Login Failure
    fail    fail
    ${USERNAME}    fail
    fail    ${PASSWORD}
    ${EMPTY}    ${EMPTY}