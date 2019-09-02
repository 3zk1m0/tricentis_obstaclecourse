    
*** Settings ***
Suite Setup         Open Obstacle Browser
#Suite Teardown      Close All Browsers

Test Setup          Go To Obstacle
Test Teardown       Verify Complite

Library             SeleniumLibrary     run_on_failure=Nothing
Library             DateTime
Library             String
Library             XML
Library             OperatingSystem
Library             Collections

*** Variables ***
${BROWSER}          Chrome
${URL}              https://obstaclecourse.tricentis.com/Obstacles/
${DOWNLOAD_DIR}     ${CURDIR}${/}Downloads


*** Test Cases ***

Twins
    [Tags]  12952
    Click Element   xpath=(//a[contains(.,"I am the one!")])[2]

Dropdown Table
    [Tags]  14090
    Click Element   id=generate
    : FOR    ${INDEX}    IN RANGE    1    6
    \   ${tmp}  Get Text    xpath=(//table[@id="comboboxTable"]//td[@class="task"])[${INDEX}]
    \   ${letter}   Set Variable    ${tmp[-1]}
    \   ${label}  Get Text    xpath=(//table[@id="comboboxTable"]//td[@class="value"]/select)[${INDEX}]/option[starts-with(.,'${letter}')]
    \   Select From List By Label   xpath=(//table[@id="comboboxTable"]//td[@class="value"]/select)[${INDEX}]   ${label}
    Click Element   id=submit

TESTDATA IN A SERVICE   # EI-VALMIS
    [Tags]  16384   EI-VALMIS
    log   not done

TOMORROW
    [Tags]  19875
    ${today}     Get Current Date
    ${tomorrow}  Add Time To Date    ${today}   1 day   result_format=%d.%m.%Y
    Input Text  id=datefield    ${tomorrow}

FUTURE CHRISTMAS
    [Tags]  21269
    ${today}     Get Current Date   result_format=datetime
    ${two_years_forward}    evaluate    ${today.year}+2
    log     ${two_years_forward}
    ${christmas_weekday}    Convert Date	25.12.${two_years_forward}      date_format=%d.%m.%Y   result_format=%A
    Input Text  id=christmasday    ${christmas_weekday}

IDS ARE NOT EVERYTHING
    [Tags]  22505
    Click Element   xpath=//a[contains(.,"Click me!")]

TODOLIST
    [Tags]  23292
    : FOR    ${INDEX}    IN RANGE    1    7
    \   Drag And Drop   xpath=//tr[contains(@class, "ui-draggable") and ./td[contains(.,"${INDEX}")]]  id=completed-tasks

AND COUNTING
    [Tags]  24499
    ${text}     Get Text    id=typeThis
    Input Text  id=s2id_autogen1    ${text}
    ${count}    SeleniumLibrary.Get Element Count   xpath=//li[contains(@role,"presentation")]
    Input Text  id=entryCount   ${count}

RED STRIPE  # EI-VALMIS
    [Tags]  30034   EI-VALMIS
    Click Element   id=generate
    ${red_percentage}   Get Text    id=number
    ${width}	${height}	Get Window Size
    ${red_width}    Evaluate    0.${red_percentage} * ${width} + 10
    ${red_heigt}    Evaluate    0.5 * ${height}

    Execute Javascript     document.elementFromPoint(${red_width}, ${red_heigt}).click();
    #ei osu tarkalleen

MATH
    [Tags]  32403
    ${first_value}   Get Text    id=no1
    ${second_value}  Get Text    id=no2
    ${operator}      Get Text    id=symbol1
    ${result}        evaluate    ${first_value}${operator}${second_value}
    Input Text       id=result   ${result}   

WAIT A MOMENT
    [Tags]  33678
    Click Element   id=one
    Wait Until Element Is Enabled   id=two  2 minutes
    Click Element   id=two

LOTS OF ROWS
    [Tags]  41032
    ${count}    SeleniumLibrary.Get Element Count   xpath=//table//tr
    Input Text  id=rowcount    ${count}
    Click Element   id=sample

TABLE SEARCH    # EI-VALMIS
    [Tags]  41036   EI-VALMIS   #Xpath ei jostain syystä toimi automaatiossa
    ${result}   Run Keyword And Return Status   Wait Until Page Contains Element    xpaht=//table//td[contains(.,"15")]
    Input Text   id=resulttext   ${result}

MEETING SCHEDULER
    [Tags]  41037
    ${text}     Get Text    xpath=(//table//tr[contains(.,"11:00 - 13:00")]/td)[5]
    Input Text  id=resulttext   ${text}

HALFWAY
    [Tags]  41038
    Click Element At Coordinates    id=halfButton   10  0

CLICK ME IF YOU CAN
    [Tags]  41040
    Execute Javascript  document.getElementById("buttontoclick").click()

ESCAPE
    [Tags]  41041
    Input Text  id=resulttext   {click}

TOUGH COOKIE
    [Tags]  45618
    Click Element   id=generated
    ${text}     Get Value    id=generated
    ${result}   Get Regexp Matches  ${text}     ([0123456789]+)
    Input Text  id=firstNumber   ${result}[0]
    Input Text  id=secondNumber  ${result}[1]
    Input Text  id=thirdNumber   ${result}[2]

POPUP WINDOWS   # EI-VALMIS
    [Tags]  51130   EI-VALMIS
    Click Element   id=button
    Select Window   twitter.com/Tricentis
    Close Window

CONFUSING DATES
    [Tags]  57683
    Click Element   id=generate
    ${initial_date}     Get Value   id=dateGenerated
    ${datetime}     Convert Date    ${initial_date}  result_format=datetime  date_format=%m/%d/%Y
    log     ${datetime}
    ${result_month}     Evaluate    ${datetime.month}+2
    ${result_year}  Set Variable    ${datetime.year}
    Run Keyword If  ${result_month}>12      ${result_year}  Evaluate   ${result_year}+1
    Run Keyword If  ${result_month}>12      ${result_month}  Evaluate   ${result_month}-12
    Input Text  id=dateSolution     ${result_year}-${result_month}-01
    Click Element   id=done

TOSCABOT CAN FLY    # EI-VALMIS
    [Tags]  60469   EI-VALMIS
    Drag And Drop   id=toscabot     id=to
    # jostain syystä keyword ei toimi

NOT A TABLE
    [Tags]  64161
    Click Element   id=generate
    ${text}     Get Text    xpath=//div[.="order id"]/following-sibling::div
    Input Text  id=offerId  ${text}

HIDDEN ELEMENT
    [Tags]  66666
    Click Element   id=clickthis

EMPTY
    [Tags]  66667   EI_VALMIS
    pass
    # Ei hajua

THE LAST ROW
    [Tags]  70310
    ${text}     Get Text    xpath=//tr[last()]/td[last()] 
    Input Text  id=ordervalue   ${text}

GET SUE'S NUMBER
    [Tags]  72946
    Click Element   id=downloadSolution
    Wait Until Created  ${DOWNLOAD_DIR}/Catalog.xml
    ${xml}	Parse XML	${DOWNLOAD_DIR}/Catalog.xml
    ${prefix}   Get Element Text     ${xml}  number[@id="Sue"]/prefix
    ${number}   Get Element Text     ${xml}  number[@id="Sue"]/number
    Input Text  id=NumberSue    ${prefix}${number}

TWO TIMES
    [Tags]  72954
    Double Click Element    xpath=//a[contains(@class, "btn")]
    
BUBBLE SORT
    [Tags]  73589
    :FOR    ${index}    IN RANGE    81
    \   ${first_number}     Get Text    xpath=//div[@class="bubble"]/div[1]
    \   ${second_number}     Get Text    xpath=//div[@class="bubble"]/div[2]
    \   Run Keyword If    ${first_number} > ${second_number}    Click Element     button1
    \   Click Element     button2
    \   ${status}   Run Keyword And Return Status   Page Should Contain Element     xpath=//a[@id="sample" and .="Perfect - you did it!"]
    \   Run Keyword If  ${status}   Exit For Loop

FIND AND FILL
    [Tags]  73590
    Execute Javascript      document.getElementById("actual").value = "ABC"
    Click Element   id=sample

FIND THE CHANGED CELL   # EI-VALMIS kestää liian kauan
    [Tags]  73591
    ${items}     SeleniumLibrary.Get Element Count   xpath=//table//td
    &{original} 	Create Dictionary	key=value
    &{changed} 	    Create Dictionary	key=value
    :FOR    ${index}    IN RANGE    1   ${items}+1
    \   ${value}     Get Text    xpath=(//table//td)[${index}]
    \   ${key}      SeleniumLibrary.Get Element Attribute    xpath=(//table//td)[${index}]     id
    \   Set To Dictionary	${original}	    ${key}	   ${value} 
    Log Dictionary  ${dictionary}

ADDITION
    [Tags]  78264
    ${first_value}   Get Text    id=no1
    ${second_value}  Get Text    id=no2
    ${operator}      Get Text    id=symbol1
    ${result}        evaluate    ${first_value}${operator}${second_value}
    Input Text       id=result   ${result}   

EXTRACTING TEXT
    [Tags]  81012
    ${text}     Get Text    id=alerttext
    ${result}   Get Regexp Matches  ${text}     ([0123456789\.]+)
    Input Text  id=totalamountText  ${result}

AGAIN AND AGAIN AND AGAIN
    [Tags]  81121
    :FOR    ${index}    IN RANGE    100
    \   ${status}    Run Keyword And Return Status   Page Should Contain Element     xpath=//a[@id="button" and .="Enough"]
    \   Click Element   id=button
    \   Run Keyword If  ${status}   Exit For Loop

TRICENTIS TOSCA OLYMPICS
    [Tags]  82018
    Click Element   id=start
    :FOR    ${index}    IN RANGE    10000
    \   ${status}    Run Keyword And Return Status   Page Should Contain Element     xpath=//div[@id="text" and .="You did it!"]
    \   Run Keyword If  ${status}   Exit For Loop
    \   ${left}    Run Keyword And Return Status   Page Should Contain Element     xpath=//div[@id="text" and .="Go left!"]
    \   ${right}    Run Keyword And Return Status   Page Should Contain Element     xpath=//div[@id="text" and .="Go right!"]
    \   Run Keyword If  ${left}     Press Keys     None  ARROW_LEFT
    \   Run Keyword If  ${right}    Press Keys     None  ARROW_RIGHT

BE FAST - AUTOMATE
    [Tags]  87912
    # xpath voisi olla parempi, mutta robot ei tue
    Click Element   id=loadbooks
    ${text}     Get Value   id=books
    ${xml}	Parse XML   ${text}
    ${isbn}   Get Element Text     ${xml}     book[3]/isbn
    #${isbn}   Get Element Text     ${xml}     //book[contains(.,"Testing Computer Software")]/isbn
    Input Text  id=isbn     ${isbn}

FUN WITH TABLES
    [Tags]  92248
    Click Element   xpath=//table//tr[contains(.,"John") and contains(.,"Doe")]//button[.="Edit"]

TESTING METHODS
    [Tags]  94441
    Select From List By Label   id=multiselect  Functional testing  End2End testing  GUI testing  Exploratory testing

SCROLL INTO VIEW
    [Tags]  99999
    # todo muuta scroll ilman javasciptiä
    Execute Javascript      document.getElementById("container").contentWindow.setTimeout("this.scrollTo(0, 200);",1);
    Select Frame    id=container
    #Scroll Element Into View    id=textfield
    Input Text  id=textfield    Tosca
    Unselect Frame
    Click Element   id=submit

*** Keywords ***

Open Obstacle Browser

    Empty Directory     ${DOWNLOAD_DIR}

    ${chromeOptions} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}   download.prompt_for_download=False  directory_upgrade=True  safebrowsing.enabled=True 
    Call Method    ${chromeOptions}    add_experimental_option    prefs    ${prefs}
    #Call Method    ${chromeOptions}    add_argument    --lang\=${browserLocale}
    #Call Method    ${chromeOptions}    add_argument    --headless
    #Call Method    ${chromeOptions}    add_argument    --window-size\=1024,768
    #Call Method    ${chromeOptions}    add_argument    --disable-gpu
    ${webdriverCreated} =    Run Keyword And Return Status    Create Webdriver    ${BROWSER}    chrome_options=${chromeOptions}
    Run Keyword Unless    ${webdriverCreated}    Create Webdriver    ${BROWSER}    chrome_options=${chromeOptions}

    #Create Webdriver    ${BROWSER}
    Maximize Browser Window

Go To Obstacle
    Go To   ${URL}@{TEST TAGS}[0]


Verify Complite
    Empty Directory     ${DOWNLOAD_DIR}
    Wait Until Page Contains Element    xpath=//div[contains(.,"Good job!") and contains(.,"You solved this automation problem")]
    