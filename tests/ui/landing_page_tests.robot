*** Settings ***
Library    Collections
Resource    ${CURDIR}/../../resources/keywords/generic_helpers.resource
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.resource
Resource    ${CURDIR}/../../resources/pages/landing_page.resource
Suite Setup    Navigate To Page    url=${UI_BASE_URL}
Suite Teardown    Close Page

*** Test Cases ***
Verify Landing Page Headers Render
    Wait For Page Load

Verify Links Render
    Verify Links Render