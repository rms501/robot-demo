*** Settings ***
Library    Collections
Resource    ${CURDIR}/../../resources/keywords/generic_helpers.robot
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.robot
Suite Setup    Navigate To Page    url=${UI_BASE_URL}
Suite Teardown    Close Page

*** Test Cases ***
Verify Landing Page Headers Render
    &{header_level_1_locator}    Create Dictionary    type=role    selector=heading[name="Welcome to the-internet"][level=1]    state=visible
    &{header_level_2_locator}    Create Dictionary    type=role    selector=heading[name="Available Examples"][level=2]    state=visible
    @{page_header_locators}    Create List    ${header_level_1_locator}    ${header_level_2_locator}
    Wait For Elements List    ${page_header_locators}


Verify Links Render
    &{form_authentication_link_locator}    Create Dictionary    type=role    selector=link[name="Form Authentication"]    state=visible
    @{links}    Create List    ${form_authentication_link_locator}
    Wait For Elements List    ${links}