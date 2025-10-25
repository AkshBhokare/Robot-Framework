
*** Variables ***
${LoginEmailTextBox}    //input[@type='email']
${LoginPasswordTextBox}    //input[@name='Password']
${LoginButton}    //button[@id='btnLogin']
${SearchBox}    //input[@id="txtSearch"]
${SearchButton}    //span[contains(text(),"Search")]
${DataTable}    //div[@id='datatables_info']
${NumberOfFetchedRecords}    //div[@id='datatables_info']
${ExportButton}    //span[contains(text(),'Export')]
${ExportButtonPopup}    //div[@class="swal2-popup swal2-modal swal2-show"]

${YesButton}    //button[contains(text(),'Yes')]
${LoadingIcon}    //*[name()='circle' and contains(@class,'ng-star-in')]