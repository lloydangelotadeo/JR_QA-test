*** Settings ***
Resource         ../resources/keywords/checkout_keywords.resource
Test Setup       Open Login Page
Test Teardown    Close Browser
Test Tags        checkout

*** Test Cases ***
SC-09 Complete Purchase Succeeds
    [Tags]    happy-path
    Reach Shipping Form With Item In Cart
    Submit Shipping Details    Test    User    12345
    Click Button    ${FINISH_BUTTON}
    Element Should Contain    ${COMPLETE_HEADER}    Thank you

SC-10 Missing First Name Is Rejected
    Reach Shipping Form With Item In Cart
    Submit Shipping Details    ${EMPTY}    User    12345
    Element Should Contain    ${CHECKOUT_ERROR}    First Name is required

SC-01 Invalid Postal Code Is Rejected
    [Documentation]    Site accepts "@@@@" as a postal code. Expected: an error.
    [Tags]    known-bug
    Reach Shipping Form With Item In Cart
    Submit Shipping Details    Test    User    @@@@
    Element Should Be Visible    ${CHECKOUT_ERROR}

SC-02 Empty Cart Cannot Be Checked Out
    [Documentation]    Site allows checkout with an empty cart. Expected: blocked.
    [Tags]    known-bug
    Login As Standard User
    Open Cart
    Start Checkout
    ${url}=    Get Location
    Should Not Contain    ${url}    checkout-step-one