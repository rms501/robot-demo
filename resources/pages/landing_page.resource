*** Settings ***
Library    Browser

*** Variables ***
${L1_HEADER_LOCATOR}    role=heading[name="Welcome to the-internet"][level=1]
${L2_HEADER_LOCATOR}    role=heading[name="Available Examples"][level=2]
${FORM_AUTHENTICATION_LINK_LOCATOR}    role=link[name="Form Authentication"]

*** Keywords ***
Wait For Page Load
    [Arguments]    ${timeout}=${GLOBAL_WAIT}
    Wait For Elements State    ${L1_HEADER_LOCATOR}    timeout=${timeout}
    Wait For Elements State    ${L2_HEADER_LOCATOR}    timeout=${timeout}

Verify Links Render
    ${locators}=    Get Variables
    Log To Console    ${locators}