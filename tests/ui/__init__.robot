*** Settings ***
Library    Browser
Resource    ${CURDIR}/../../resources/variables/env_vars.robot
Suite Setup    Run Keywords    New Browser    headless=${headless}    AND    New Context
Suite Teardown    Close Browser