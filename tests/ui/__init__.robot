*** Settings ***
Library    Browser
Resource    ${CURDIR}/../../resources/variables/env_vars.robot
Resource    ${CURDIR}/../../resources/keywords/browser_helpers.robot
Suite Setup    Open New Browser And Context    headless=${HEADLESS}
Suite Teardown    Close Browser