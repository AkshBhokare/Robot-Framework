*** Settings ***
Resource    ${CURDIR}/../../import.robot
Resource    ../../Keywords/generic.resource

*** Variables ***
##User Data ###
${userID}    ajbhokare143@gmail.com
${GptPassword}    Akki@143
${SearchThis}    How are You
${gptURL}    https://chat.openai.com/auth/login


##Locators###
${GPTLoginButton}    //button//div[text()="Log in"]
${ContinueBtn}    //button[contains(text(),'Continue')]
${gptUser_Loc}    //input[@id='username']
${GptPassword_Loc}    //input[@id='password']
${gptTitle}    //h1[contains(text(),'ChatGPT')]
${SearchGPT}    //textarea[@id='prompt-textarea']
${nextbtn}    //div[contains(text(),'Next')]
${dialogbox}    (//div[@role='dialog'])[1]
${donebtn}    //div[contains(text(),'Done')]
${sendSearch}    //textarea[@id='prompt-textarea']//..//button

*** Variables ***
${Product_1}    Sauce Labs Backpack
${Product_2}    Sauce Labs Bike Light


*** Test Cases ***
Test 
    ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --disable-notifications
    # Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    https://www.saucedemo.com
    Wait Until Element Is Visible    id=login-button    10s
    Input Text    id=user-name    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button
    wait Until Element Is Visible    //div[contains(text(),"Swag Labs")]    10s
    wait and Click Element    //div[text()="${Product_1}"]//../../..//button[text()='Add to cart']
    
    wait Until Element Is Visible    //div[text()="${Product_1}"]//../../..//button[text()='Remove']    10s

    wait Until Element Is Visible    //div[contains(text(),"Swag Labs")]    10s
    wait and Click Element    //div[text()="${Product_2}"]//../../..//button[text()='Add to cart']
    wait Until Element Is Visible    //div[text()="${Product_2}"]//../../..//button[text()='Remove']

    Click Element    id=shopping_cart_container
    wait Until Element Is Visible    //span[contains(text(),"Your Cart")]    10s

    ${CartItems}    Get WebElements    //div[@class='cart_list']//div[@class='cart_item']
    ${ItemCount}    Get Length    ${CartItems}
    Should Be Equal As Integers    ${ItemCount}    2
    FOR    ${item}    IN    @{CartItems}
        ${CartItemLabel}    Get Text    xpath=//div[@class='inventory_item_name']
        Should be Equal    ${Product_1}    ${CartItemLabel}
    END

