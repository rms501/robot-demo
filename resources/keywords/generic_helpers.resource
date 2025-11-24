*** Settings ***
Library    DebugLibrary
Resource    ../variables/env_vars.resource

*** Keywords ***
Breakpoint
    Run Keyword If    ${DEBUG_MODE} == True    Debug