*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/login_page.resource

*** Variables ***
${URL}        https://www.saucedemo.com
${BROWSER}    chrome

*** Keywords ***
Open Login Page
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Swag Labs

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text      ${USERNAME_INPUT}    ${username}
    Input Text      ${PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}

Login Should Show Error
    [Arguments]    ${username}    ${password}    ${expected_error}
    Login With Credentials    ${username}    ${password}
    Element Should Be Visible    ${ERROR_MESSAGE}
    Element Should Contain       ${ERROR_MESSAGE}    ${expected_error}