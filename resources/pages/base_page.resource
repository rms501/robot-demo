*** Settings ***
Library    Browser

*** Keywords ***
Wait For Elements List
[Arguments]    ${locators}
FOR    ${locator}    IN    @{locators}
    ${type}=    Get From Dictionary    ${locator}    type
    ${selector}=    Get From Dictionary    ${locator}    selector
    ${state}=    Get From Dictionary    ${locator}    state
    ${timeout}=    Get From Dictionary    ${locator}    timeout    default=${GLOBAL_WAIT}
    &{args}=    Create Dictionary    state=${state}    timeout=${timeout}
    Wait For Elements State    ${type}=${selector}    &{args}
END