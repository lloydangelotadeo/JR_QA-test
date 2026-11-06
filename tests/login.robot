*** Settings ***
Resource         ../resources/keywords/login_keywords.resource
Test Setup       Open Login Page
Test Teardown    Close Browser
Test Template    Login Should Show Error
Test Tags        login

*** Test Cases ***                          USERNAME           PASSWORD        EXPECTED ERROR
SC-03 Wrong Password Is Rejected            standard_user      wrong_pass      Username and password do not match
SC-04 Empty Fields Are Rejected             ${EMPTY}           ${EMPTY}        Username is required
SC-05 Locked Out User Is Rejected           locked_out_user    secret_sauce    locked out