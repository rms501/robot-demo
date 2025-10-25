#TODO: Expand scope of tests to other methods and scenarios, e.g. negative tests/4XX cases
*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ${CURDIR}/../../resources/variables/env_vars.robot
Resource    ${CURDIR}/../../resources/keywords/generic_helpers.robot
Resource    ${CURDIR}/../../resources/keywords/requests_helpers.robot
Suite Setup    Create Session    sess    ${API_BASE_URL}
Suite Teardown    Delete All Sessions

*** Variables ***
${PATH}    students/
${LATENCY_THRESHOLD}    3
&{KEYS}    id=int    first_name=str    last_name=str    age=int    score=int

*** Keywords ***
# TODO: See if you can make this generic with recursion, and invert check to find superfluous entity keys.
Validate Student
    [Arguments]    ${student}
    Should Be True    isinstance(${student}, dict)
    FOR    ${key}    ${type}    IN    &{KEYS}
        Dictionary Should Contain Key    ${student}    ${key}
        IF    ${type} == str
            ${value}=    Set Variable    '${student}[${key}]'
        ELSE
            ${value}=    Set Variable    ${student}[${key}]
        END
        Should Be True    isinstance(${value}, ${type})
    END

Create Student Test Setup
    [Arguments]    ${student}
    ${response}=    Post On Session    sess    ${PATH}    json=${student}
    Validate Response Success    ${response}
    ${body}=    Set Variable    ${response.json()}
    Validate Student    ${body}
    Set Test Variable    ${id}    ${response.json()['id']}

Delete Student Test Teardown
    # TODO: Discover robust solution for logging failures for reply.
    [Arguments]    ${id}
    ${response}=    Delete On Session    sess    ${PATH}${id}
    Validate Response Success    ${response}

*** Test Cases ***
Students Get Test
    ${response}=    Get On Session    sess    ${PATH}
    Validate Response Success    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Be True    isinstance(${body}, list)
    FOR    ${student}    IN    @{body}
        Validate Student    ${student}
    END

Student Get Test
    [Setup]    Create Student Test Setup   ${{ {'first_name': 'test', 'last_name': 'test', 'age': 100, 'score': 100} }}
    ${response}=    Get On Session    sess    ${PATH}${id}
    Validate Student    ${response.json()}
    [Teardown]    Delete Student Test Teardown    ${id}