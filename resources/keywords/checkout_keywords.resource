*** Settings ***
Resource    login_keywords.resource
Resource    ../pages/checkout_page.resource

*** Keywords ***
Login As Standard User
    Login With Credentials    standard_user    secret_sauce
    Location Should Contain    inventory

Add Backpack To Cart
    Click Button    ${ADD_BACKPACK}

Open Cart
    Click Element    ${CART_LINK}

Start Checkout
    Click Button    ${CHECKOUT_BUTTON}

Submit Shipping Details
    [Arguments]    ${first}    ${last}    ${postal}
    Input Text      ${FIRST_NAME_INPUT}     ${first}
    Input Text      ${LAST_NAME_INPUT}      ${last}
    Input Text      ${POSTAL_CODE_INPUT}    ${postal}
    Click Button    ${CONTINUE_BUTTON}

Reach Shipping Form With Item In Cart
    Login As Standard User
    Add Backpack To Cart
    Open Cart
    Start Checkout