
*** Settings ***
Resource    ${CURDIR}/../import.robot

*** Variables ***
# ${Browser}        Chrome
# ${URL}            https://qa.artegosandbox.com/login
# ${Username}       akshay.bhokare@911fintech.com
# ${Password}       Akshay@1234
#&{URL}    QA=https://qa.artegosandbox.com/login    QA1=https://qa1.artegosandbox.com/login
#@{dropdown_list}    Processor    Card Type    Dropdown 3
   
   
*** Keywords ***
#For Login Browser
Fi911 Open Browser and Login
    [Documentation]    Opens a browser, navigates to a URL, and performs a login using the provided credentials.

    ...     \n Example usage:
    ...     - Fi911 Open Browser and Login    https://example.com/login    user@example.com    password123

    ...     \n Notes:
    ...     - Make sure you have the appropriate browser driver installed and set up properly for the chosen browser.
    ...     - This keyword assumes that the login page contains identifiable elements such as email input, password input, and a login button. Make sure to update the element identifiers in the keyword implementation to match your specific login page.
    ...     - Please note that this keyword does not handle any potential error cases during the login process. You may need to add additional error handling or validations based on your specific requirements.

    [Arguments]        ${URL}    ${Username}    ${Password}    ${Browser}=chrome
    Open Browser    ${URL}    ${Browser}    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Wait Until Page Contains Element    ${LoginEmailTextBox}    10s
    Input Text    ${LoginEmailTextBox}    ${Username}

    Input Text    ${LoginPasswordTextBox}    ${Password}
    Click Button    ${LoginButton}

Wait and Click Element
    [Arguments]    ${xpath}    ${timeout}=10s
    [Documentation]    Waits for an element identified by XPath to appear on the page, become visible, and enabled. Once the element satisfies these conditions, it is clicked.

    ...    \n Example usage:
    ...     - Wait and Click Element    //button[@id='submit-button']    20s

    ...    \n Notes:
    ...    - Make sure to provide a valid XPath locator for the element you want to wait for and click.
    ...    - The timeout value specifies the maximum time to wait for the element to appear, become visible, and enabled.
    
    ...    \n This keyword performs the following steps:
    ...      1. Waits for the element identified by the XPath to appear on the page for a maximum of ${timeout}.
    ...      2. Waits for the element to become visible on the page.
    ...      3. Waits for the element to become enabled and interactable.
    ...      4. Finally, clicks the element.

    Wait Until Page Contains Element    ${xpath}    ${timeout}
    Wait Until Element Is Visible    ${xpath}    ${timeout}
    Wait Until Element Is Enabled    ${xpath}    ${timeout}
    Click Element    ${xpath}

#For Selecting Module and Submodule
Fi911 Select Module
    [Arguments]    ${module}    ${subModule}=None 
    [Documentation]    Selects a module and its submodule (if provided) in the Artego Site.

    ...     \n Example usage:
    ...      - eg1 : Fi911 Select Module    Dashboard
    ...      - eg2 : Fi911 Select Module    Transactions    Settlement
    
    ...    \n Notes:
    ...    - Make sure to provide the correct names of the module and submodule to be selected.
    ...    - The keyword assumes that the module and submodule elements will eventually appear on the page.

    IF    '${submodule}' == 'None'
        Wait and Click Element   //p[contains(text(),"${module}")]    40s
    ELSE
        Wait and Click Element   //p[contains(text(),"${module}")]    40s
        ${isDropdownCollapsed}    Run Keyword And Return Status    Element Should Be Visible    //p[contains(text(),'${module}')]//../..//a[contains(@class,"collapsed")]
        IF    '${isDropdownCollapsed}' == 'False'
            Log    Dropdown is Open
            Scroll Element Into View    //span[contains(text(),"${submodule}")]
            Wait and Click Element    //span[contains(text(),"${submodule}")]    20s
        ELSE
            Log    Dropdown is closed
            Wait and Click Element    //p[contains(text(),"${module}")]
            Wait and Click Element    //span[contains(text(),"${submodule}")]    30s
            Scroll Element Into View    //span[contains(text(),"${submodule}")]
            
        END
    END


#For titel Verification
Fi911 Verify Page Title
    [Arguments]    ${expected_title}
    [Documentation]    Verifies the page title against an expected title in the Fi911 application.

    ...    \n Example usage:
    ...     - eg1: Fi911 Verify Page Title    Dashboard
    ...     - eg2: Fi911 Verify Page Title    Transaction/Authorizations

    ...    \n Notes:
    ...    - Make sure to provide the correct expected title for the page you want to verify.
    ...    - The keyword compares the expected title with the actual title using a string comparison.
   
    ${actual_title}=    Get Title
    Run Keyword If    '${expected_title}' == '${actual_title}'    Log    Page title is as expected: ${expected_title}
    ...    ELSE    Log    Page title is not as expected. Expected: ${expected_title}, Actual: ${actual_title}
    

#Select Child Module
Fi911 Select Child Module
    [Arguments]    ${Childmodule}
    [Documentation]    Selects a child module within a parent module in the Artego application.

    ...    \n Example usage:
    ...     -  Fi911 Select Child Module    Custom Filter

    ...    \n Notes:
    ...      - Make sure to provide the correct name of the child module to be selected.
    ...      - The keyword assumes that the child module element will eventually appear on the page within the parent module.
    ...      - The timeout value used for waiting and clicking the element can be customized as per your requirements.

    ...    \n This keyword performs the following steps:
    ...       1. Waits for the child module element to appear on the page within the parent module.
    ...       2. Clicks the child module element.


    Wait and Click Element    //a[contains(text(),"${Childmodule}")]    40s
    
    
#For Caledar Handling
Fi911 Select Date
    [Arguments]    ${start_or_end}    ${year}    ${month}    ${date}

    [Documentation]    Pass StartDate or EndDate Year(eg 2023) Month in capital Letters (eg.JAN) Date (eg.06)
    ...       Selects a date in the Artego based on the start or end date.

    ...    \n Example usage:
    ...     -  Fi911 Select Date    StartDate    2023    JAN    06
    ...     -  Fi911 Select Date    EndDate    2023    FEB    15

    ...    \n Notes:
    ...     - Make sure to provide the correct start or end date, year, month, and date.
    ...     - The keyword assumes that the date picker element and the calendar elements will appear on the page.
    ...     - The timeout values used for waiting and clicking elements can be customized as per your requirements.


    Scroll Element Into View    //span[contains(text(),"${start_or_end}")]/../../../..//button    
    Click Element    //span[contains(text(),"${start_or_end}")]/../../../..//button
    Wait and Click Element    //div[@class='mat-calendar-arrow']    30s
    #   //button[@aria-label='Choose month and year']    40s    
    Click Element    //div[contains(@class,"calendar")]//div[contains(text(),"${year}")]    
    Wait Until Page Contains Element    //td[@class="mat-calendar-body-label"]
    Wait and Click Element    //div[contains(text(),"${month}")]    10s
    Click Element    //div[contains(@class,"calendar")]//div[contains(text()," ${date}")]


Fi911 Search Records
    [Arguments]    &{SearchParameters}
    [Documentation]    Searches records in the Fi911 application based on the provided search parameters.

    ...    \n Example usage:
    ...      - In Varibles : &{SearchParameters}=    Create Dictionary    Start Date=06/01/2023    Status=Active    dd.Priority=High
    ...      - In Test Case : Fi911 Search Records    &{SearchParameters}

    ...     \n Notes:
    ...     - Make sure to provide the correct search parameters based on the field names and expected values.
    ...     - The keyword assumes that the search box, input elements, dropdown lists, and search button will appear on the page.
    ...     - The timeout values used for waiting and clicking elements can be customized as per your requirements.
   
    Wait and Click Element    ${SearchBox}    30s
    FOR    ${key}    ${value}    IN    &{SearchParameters}
    
        # Wait Until Element Is Visible    //span[contains(text(),"${key}")]//../../..//input
        # Click Element    //span[contains(text(),"${key}")]
        
        #${isDropdown}    Run Keyword And Return Status    List Should Contain Value    ${dropdown_list}    ${key}
        IF    "${key}"[:3] == "dd."
        Log    The string contains "dd
            ${modifiedKey}    Set Variable    ${key}[3:]
            Wait and Click Element    //*[@role="combobox"]//span[contains(text(),"${modifiedKey}")]    30s
            Scroll Element Into View    //div[@role="listbox"]//span[contains(text(),"${value}")]
            Wait and Click Element    //div[@role="listbox"]//span[contains(text(),"${value}")]
      
        ELSE IF    '${key}'=='Start Date' or '${key}'=='End Date'
            ${dateParts}    Split String    ${value}    /
            ${date}    Set Variable    ${dateParts}[0]
            ${month}    Set Variable    ${dateParts}[1]
            ${year}    Set Variable    ${dateParts}[2]
            # Process the day, month, and year separately as neededx
            Fi911 Select Date    ${key}   ${year}    ${month}    ${date}
        ELSE
            Wait and Click Element    //span[contains(text(),"${key}")]//../../..//input    20s
            Input Text    //span[contains(text(),"${key}")]//../../..//input    ${value}
        END
    END
    Scroll Element Into View    ${SearchButton}
    Wait and Click Element    ${SearchButton}    30s


    
Fi911 Check Records 
    [Documentation]    Checks if records are available in the Fi911 application and performs actions accordingly.

    ...    \n Example usage:
    ...     -  Fi911 Check Records

    ...    \n Notes:
    ...      - This keyword assumes that the table containing the records is identified by the XPath //tbody//tr[@role='row'].
    ...      - The timeout value used for checking element visibility and waiting for element click can be customized as per your requirements.

    ${isElementVisible}    Run Keyword And Return Status    Element Should Be Visible    //tbody//tr[@role='row']    40s
    IF    '${isElementVisible}' == 'True'
    
        Scroll Element Into View    ${DataTable}
        Wait and Click Element    ${DataTable}    20s
        ${Total_Recores}    Get Text    ${NumberOfFetchedRecords}
        Log To Console    Total Records: ${Total_Recores}
        Fi911 Export Records

    ELSE
        Log    Records not Available
    END
    

Fi911 Export Records
    [Documentation]    Performs the export of records in the Fi911 application and handles the export options and pop-ups.
    
    ...    \n Example usage:
    ...         - Fi911 Export Records

    ...    \n Notes:
    ...      - The timeout value used for waiting for page load, checking element visibility, and waiting for element click can be customized as per your requirements.
    ...      - Modify the export button element, export button popup element, "No records found" popup element, "count exceeds" popup element, and "Yes" button element based on the specific implementation in your application.
    ...      - You may need to add additional actions or validations based on your specific requirements during the export process.

    Fi911 Wait For Page Load
    
    Scroll Element Into View    ${ExportButton}
    Wait and Click Element    ${ExportButton}    30s
    ${isPopupVisible}    Run Keyword And Return Status    Element Should Be Visible    ${ExportButtonPopup}
    IF    '${isPopupVisible}' == 'True'
        ${isNoRecordsPopUpVisible}    Run Keyword And Return Status    Element Should Be Visible    //div[contains(text(),"No records found")]
        ${MoreThanExpectedRecores}    Run keyword And Return Status    Element Should Be Visible    //div[contains(text(),'count exceeds')]
        # ${popupText}    Get Text    //div[contains(text(),"No records found")]
        IF    '${isNoRecordsPopUpVisible}' == 'True'  
            Wait and Click Element    ${OkButton}    30s
            Log To Console    Records not available
        
        
        ELSE IF    '${MoreThanExpectedRecores}' == 'True'   
            
            
            Log To Console    Records More then 200000
            Wait and Click Element    ${OkButton}    30s

        ELSE     #IF    '${isYesButtonVisible}' == 'True'

            ${isYesButtonVisible}    Run Keyword And Return Status    Element Should Be Visible    //button[contains(text(),'Yes')]
            # enter email passed by user
            Wait and Click Element    ${YesButton}    10s
            Log To Console    Records sent on email
        END
    ELSE
        Log    Records downloaded as Excel sheet
        # Ask user to pass download directory, verify in mentioned download directory
    END


#xpath of loading ICON = //*[name()='circle' and contains(@class,'ng-star-in')]
Fi911 Wait For Page Load
    [Documentation]    Waits for the page to finish loading by waiting until a specific loading icon element is no longer present on the page.
     
    ...    \n Example usage:
    ...     -  Fi911 Wait For Page Load

    ...    \n Notes:
    ...      - Adjust the timeout value according to the time it takes for the page to finish loading in your application.

    Wait Until Page Does Not Contain Element    ${LoadingIcon}    50s


Fi911 Pagination
    [Documentation]    Handles pagination in a data table by selecting the desired number of records per page and navigating to the specified page number.
   
    ...    \n Example usage:
    ...     -  Fi911 Pagination    10    3

    ...    \n Arguments:
    ...     - ${NoOfRecords}: The number of records to be displayed per page.
    ...     - ${PageNumber}: The target page number to navigate to.

    ...    \n Notes:
    ...     - Modify the element selectors as per your application's specific data table structure.
    ...     - Ensure that the page length dropdown element contains the desired number of records per page options.

    Fi911 Wait For Page Load
    Wait Until Element Is Visible    //div[@id='datatables_length']/../..    30s
    Scroll Element Into View    //div[@id='datatables_length']/../..
    Wait and Click Element    //*[@id="datatables_length"]/label/select    

    [Arguments]    ${NoOfRecords}    ${PageNumber}    
    Wait and Click Element    //div[@id='datatables_length']//option[contains(text(),'${NoOfRecords} ')]

    # ${PageNumber}    Set Variable    123    # Assuming ${value} is a string containing a numeric value
    # ${integerValue}    Convert To Integer    ${PageNumber}
    # Log    Converted integer value: ${integerValue}

    # Click on the 'Next' button until the target page is visible
    FOR    ${buttonIndex}    IN RANGE    1    ${PageNumber}
        Wait Until Element Is Visible    //div//ul//a[normalize-space()='Next']
        Click Element    //div//ul//a[normalize-space()='Next']
    END