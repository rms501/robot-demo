*** Settings ***
Library    Browser
Library    Collections
Resource    ../resources/variables/env_vars.robot
Resource    ../resources/keywords/browser_helpers.robot
Suite Setup    Navigate To Page    url=${BASE_URL}    headless=${HEADLESS}
Suite Teardown    Close Browser

*** Test Cases ***
Verify Landing Page Headers Render
    &{header_level_1_locator}    Create Dictionary    type=role    selector=heading[name="Welcome to the-internet"][level=1]    state=visible
    &{header_level_2_locator}    Create Dictionary    type=role    selector=heading[name="Available Examples"][level=2]    state=visible
    @{page_header_locators}    Create List    ${header_level_1_locator}    ${header_level_2_locator}
    Wait For Elements List    @{page_header_locators}

Verify Links Render
    &{form_authentication_link_locator}    Create Dictionary    type=role    selector=link[name="Form Authentication"]    state=visible
    @{links}    Create List    ${form_authentication_link_locator}
    Wait For Elements List    @{links}