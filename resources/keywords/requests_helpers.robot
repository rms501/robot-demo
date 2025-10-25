*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Validate Response Success
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Should Be True    ${response.elapsed.total_seconds()} < ${LATENCY_THRESHOLD}