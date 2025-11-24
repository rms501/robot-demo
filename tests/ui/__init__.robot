*** Settings ***
Library    Browser
Resource    ${CURDIR}/../../resources/variables/env_vars.resource
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.resource
Suite Setup    Open New Browser And Context    headless=${HEADLESS}
Suite Teardown    Close Browser