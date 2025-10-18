*** Settings ***
Library     Browser
Resource    ../resources/variables/env_vars.robot
Resource    ../resources/keywords/browser_helpers.robot
Test Setup    Navigate To Page    url=${BASE_URL}${LOGIN_PAGE_PATH}    headless=${HEADLESS}
Test Teardown    Close Browser

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
    Wait For Elements State    role=${page_header_selector}    visible    timeout=${GLOBAL_WAIT}

Verify Login Workflow Success
    Login    tomsmith    SuperSecretPassword!
    &{success_banner_locator}    Create Dictionary    type=xpath    selector=//div[@class='flash success']    state=visible
    &{success_header_locator}    Create Dictionary    type=role    selector=heading[name='Secure Area'][level=2]    state=visible
    @{success_locators}    Create List    ${success_banner_locator}    ${success_header_locator}
    Wait For Elements List    @{success_locators}
    Click    xpath=//a[@href='/logout']
    Wait For Elements State    role=${page_header_selector}    visible    timeout=${GLOBAL_WAIT}

Verify Login Failure
    Login    fail    fail
    Wait For Elements State    xpath=//div[@class='flash error']    visible    timeout=${GLOBAL_WAIT}