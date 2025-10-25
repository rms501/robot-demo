*** Settings ***
Library    DebugLibrary
Resource    ../variables/env_vars.robot

*** Keywords ***
Breakpoint
    Run Keyword If    ${DEBUG_MODE} == True    Debug