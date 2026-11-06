*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open Saucedemo
    Open Browser    https://www.saucedemo.com    chrome
    Title Should Be    Swag Labs
    [Teardown]    Close Browser