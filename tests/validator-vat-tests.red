Red [
    Title: "VAT validator tests"
    Description: "Testing functionality of VAT validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-vat-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/validator.red
    ]

    /local valid-vat-numbers: [
        ;-- austria
        "ATU13585627"
        "ATU13585626"
        ;-- belgium
        "BE0428759497"
        "BE1187141811"
        "BE431150351"
        "BE999.999.999"
        ;-- bulgaria
        "BG175074752"
        "BG7523169263"
        "BG8032056031"
        "BG7542011030"
        "BG7111042925"
        "BG175074753"
        "BG7552110004"
        "BG7111042922"
        ;-- croatia
        "HR33392005961"
        "HR33392005962"
        "HR12345678901"
        ;-- cyprus
        "CY10259033P"
        "CY10259033Z"
        "CY12051126A"
        "CY1205Z12XS"
        ;-- czech-republic
        "CZ25123891"
        "CZ7103192745"
        "CZ991231123"
        "CZ640903926"
        "CZ25123890"
        "CZ1103492745"
        "CZ590312123"
        ;-- denmark
        "DK13585628"
        "DK13585627"
        ;-- estonia
        "EE100931558"
        "EE100594102"
        "EE100594103"
        ;-- finland
        "FI20774740"
        "FI20774741"
        ;-- france-monaco
        "FR40303265045"
        "FR23334175221"
        "FRK7399859412"
        "FR4Z123456782"
        "FR84323140391"
        ;-- germany
        "DE136695976"
        "DE136695978"
        ;-- greece
        "GR023456780"
        "EL094259216"
        "EL123456781"
        ;-- hungary
        "HU12892312"
        "HU12892313"
        ;-- ireland
        "IE6433435F"
        "IE6433435OA"
        "IE8D79738J"
        "IE8+79738J"
        "IE8*79738J"
        "IE1234567TW"
        ;-- italy
        "IT00743110157"
        "IT00743110158"
        ;-- latvia
        "LV40003521600"
        "LV16117519997"
        "LV40003521601"
        "LV16137519997"
        ;-- lithuania
        "LT119511515"
        "LT100001919017"
        "LT100004801610"
        "LT100001919018"
        ;-- luxembourg
        "LU15027442"
        "LU15027443"
        ;-- malta
        "MT11679112"
        "MT11679113"
        ;-- netherlands
        "NL004495445B01"
        "NL123456789B90"
        ;-- poland
        "PL8567346215"
        "PL4673742025"
        "PL4856949716"
        "PL3982429194"
        "PL5826406006"
        "PL3624253337"
        "PL4132636464"
        "PL9788951553"
        "PL5688936871"
        "PL6936767941"
        "PL7918817787"
        "PL9924161648"
        ;-- portugal
        "PT501964843"
        "PT501964842"
        ;-- romania
        "RO12"
        "RO411"
        "RO4133"
        "RO21511"
        "RO722253"
        "RO2362232"
        "RO4594917"
        "RO18547290"
        "RO18547291"
        "RO912397659"
        "RO124626660"
        ;-- slovakia
        "SK2022749619"
        "SK2022749618"
        ;-- slovenia
        "SI50223054"
        "SI50223055"
        ;-- spain
        "ES54362315K"
        "ESX2482300W"
        "ESX5253868R"
        "ESM1234567L"
        "ESJ99216582"
        "ESB58378431"
        "ESB64717838"
        "ES54362315Z"
        "ESX2482300A"
        "ESJ99216583"
        ;-- sweden
        "SE123456789701"
        "SE123456789101"
        "SE123456789012"
        ;-- united-kingdom-isle-of-man
        "GB980780684"
        "GB802311781"
        "GB123456789012"
        "GBGD123"
        "GBHA456"

        ; ------ Latin American countries
        ;-- argentina
        "AR12345678901"
        "AR98325515734"
        ;-- bolivia
        "BO1234567"
        "BO8262353"
        ;-- brazil
        "BR12345678901234"
        "BR12345678901"
        "BR11.111.111/0001-55"
        "BR123.456.789-00"
        ;-- chile
        "CL87654321-2"
        "CL21472149-5"
        ;-- colombia
        "CO9876543210"
        "CO9231571951"
        ;-- costa-rica
        "CR123456789012"
        "CR895718957157"
        "CR12421401444"
        "CR2189509595"
        "CR098714644"
        ;-- ecuador
        "EC1234567890123"
        "EC2582028582271"
        ;-- guatemala
        "GT1234567-1"
        "GT5395338-3"
        ;-- mexico
        ;"MX"
        "MX123 456789 123"
        "MX123456789123"
        "MXP&G851223B24"
        "MXAAGB860519G31"
        ;-- nicaragua
        "NI123-123456-1234A"
        "NI743-724723-2421X"
        ;-- paraguay
        "PY123456-1"
        "PY166235-6"
        ;-- peru
        "PE12345678901"
        "PE29429181550"
        ;-- dominican-republic
        "DO12345678901"
        "DO32582539252"
        "DO123456789"
        "DO089571253"
        ;-- uruguay
        "UY1.123.123-1"
        "UY5.623.255-7"
        "UY2.214.222-3"
        ;-- venezuela
        "VEJ309272292"
        "VEV242818101"
        "VEJ000126518"
        "VEJ309272293"
        "VEJ000458323"
        "VEJ-305959918"
        "VEJ-30595991-8"
        "VEJ305959918"
        "VEJ30595991-8"

        ; ------ Other countries
        ;-- albania
        "ALK12345678L"
        "ALK52236322X"
        "ALJ12345678L"
        "ALJ52263223X"
        ;-- australia
        "AU123456789"
        "AU215215282"
        ;-- belarus
        "BY190190190"
        "BY326236232"
        ;-- canada
        "CA123456789012345"
        "CA235638252952128"
        ;-- iceland
        "IS12345"
        "IS123456"
        "IS1234567"
        ;-- india
        "IN12345678901V"
        "IN12345678901C"
        "IN17224662447V"
        "IN10218957234C"
        ;-- indonesia
        "ID022718241413000"
        "ID02.271.824.1-413.000"
        "ID09.322.131.5-325.131"
        ;-- israel
        "IL123456789"
        "IL023456789"
        "IL000056789"
        "IL000000014"
        ;-- new-zealand
        "NZ1234567890123"
        "NZ3253852395833"
        ;-- norway
        "NO123456789MVA"
        "NO327583593MVA"
        ;-- philippines
        "PH123456789012"
        "PH342583468624"
        ;-- russia
        "RU111101011012"
        "RU1111928422"
        "RU5555111111"
        ;-- san-marino
        "SM12345"
        "SM62363"
        ;-- serbia
        "RS129456789"
        ;-- south africa
        "ZA4012345678"
        "ZA40123456789"
        "ZA3012345678"
        ;-- switzerland
        "CH321231"
        "CHE123456788TVA"
        "CHE123456788MWST"
        "CHE123456788IVA"
        ;-- turkey
        "TR9876543210"
        "TR2349568463"
        ;-- ukraine
        "UA1274182716"
        "UA432569356211"
        ;-- uzbekistan (valid only 2xx, 4-7xx)
        "UZ200000000"
        "UZ299999999"
        "UZ400000000"
        "UZ499999999"
        "UZ500000000"
        "UZ599999999"
        "UZ600000000"
        "UZ699999999"
        "UZ700000000"
        "UZ799999999"
    ]

    /local invalid-vat-numbers: [
        ;-- austria
        "ATU1358562"
        "AT13585626"
        ;-- belgium (invalid first digit 2-9)
        "BE2428759497"
        "BE3187141811"
        "BE4131150351"
        "BE5131150351"
        "BE6131150351"
        "BE7131150351"
        "BE8131150351"
        "BE9131150351"
        "BE1999.999.999"
        ;-- bulgaria
        "BG17507475"
        "BG7523163"
        ;-- croatia
        "HR12345671"
        ;-- cyprus
        "CY102533P"
        "CY10253Z"
        ;-- czech-republic
        "CZ11034924145"
        "CZ5901212"
        ;-- denmark
        "DK13585X27"
        "DK135856"
        ;-- estonia
        "EE10059410"
        ;-- finland
        "FI20774740Q"
        ;-- france-monaco
        "FR4030326504"
        "FR23334121"
        ;-- germany
        "DE13669597"
        ;-- greece
        "GR0234567680"
        "EL09425216"
        ;-- hungary
        "HU128923113"
        ;-- ireland
        "IE12345678TW"
        "IE8>79738J"
        "IE8;79738J"
        ;-- italy
        "IT007431101"
        ;-- latvia
        "LV40003501"
        ;-- lithuania
        "LT1195112515"
        ;-- luxembourg
        "LU15027442X"
        ;-- malta
        "MT1167911A"
        ;-- netherlands
        "NL00449544501"
        "NL123456789X90"
        "NL12349B90"
        ;-- poland
        "PL1234567890"
        "PL0987654321"
        "PL1234543211"
        "PL0987656789"
        "PL1111111112"
        "PL2222222221"
        "PL000000001"
        "PL12332113"
        ;-- portugal
        "PT501964"
        ;-- romania
        "RO1"
        "RO12X"
        "RO12345678901"
        ;-- slovakia
        "SK20749619"
        ;-- slovenia
        "SI502254"
        ;-- spain
        "ES543622315K"
        "ES54362315"
        "ESX4362315"
        "ES2482300A"
        ;-- sweden
        "SE123451101"
        ;-- united-kingdom-isle-of-man
        "GB9800684"
        "GB12345678011"
        "GBGA123"
        "GBDA13456"

        ; ------ Latin American countries
        ;-- argentina
        "ARX5115151555"
        "AR1234567890"
        "AR983255157343"
        ;-- bolivia
        "BO123456714"
        "BO82623532B"
        ;-- brazil
        "BR1234567890124"
        "BR1234567801"
        "BR11.11.111/0001-55"
        "BR11.111.1110001-55"
        "BR11.111.111/000155"
        "BR11111111/000155"
        "BR123.456.78900"
        "BR123457789-00"
        ;-- chile
        "CL87654321-22"
        "CL214721495X"
        "CL876543212"
        ;-- colombia
        "CO98765432101"
        "CO923171951"
        ;-- costa-rica
        "CR1234567890122"
        "CR09871464"
        "CR09871464A1"
        "CR09871464AX"
        ;-- ecuador
        "EC1234567"
        "EC258202858227-1"
        ;-- guatemala
        "GT12345671"
        "GT53953383"
        "GT1234567-11"
        "GT5395338-23"
        "GT123456-71"
        "GT539533-83"
        ;-- mexico
        "MX123456789"
        "MXP&G85X223B24"
        "MXAAGB86T519G31"
        ;-- nicaragua
        "NI123-123456-1234"
        "NI743-724723-2421"
        "NI1231234561234"
        "NI7437247212421"
        "NI1231234561234A"
        "NI7437247212421X"
        "NI123123456-1234A"
        "NI743-7247232421X"
        "NI7437247232421X"
        ;-- paraguay
        "PY1234561"
        "PY1662356"
        "PY1662356124-1"
        ;-- peru
        "PE123456789012"
        "PE29429180"
        ;-- dominican-republic
        "DO123-4567-8901"
        "DO3258-2539-252"
        "DO123-45-67-89"
        "DO0895712531"
        ;-- uruguay
        "UY1123.123-1"
        "UY5623255-7"
        "UY2.214.2223"
        ;-- venezuela
        "VEJ3092752292"
        "VE242818101"
        "VE0001265168"
        "VEJ-30595998"
        "VEJ3059599991-8"

        ; ------ Other countries
        ;-- albania
        "ALK123567892"
        "ALK12356789"
        "ALK52263223"
        "ALZ12356789L"
        "ALY52263223X"
        "AL112356789L"
        "AL52233223X"
        "ALJ12356789"
        "ALJ52263223"
        ;-- australia
        "AU12353456789"
        "AU2153215282"
        ;-- belarus
        "BY1902190190"
        "BY326236232X"
        ;-- canada
        "CA123789012345"
        "CA2356352128"
        ;-- iceland
        "IS12232345"
        "IS123424456"
        "IS123456-7"
        ;-- india
        "IN12345678901X"
        "IN12345678901S"
        "IN1722466244V"
        "IN10218957C"
        ;-- indonesia
        "ID022718241413"
        "ID02.271.824.1-413000"
        "ID02.271.824.1413.000"
        "ID02.271.824141-3.000"
        "ID02.271824.141-3.000"
        "ID02271.824.141-3.000"
        "ID12271824141-3000"
        ;-- israel
        "IL1231456789"
        "IL0256789"
        "IL0000"
        ;-- new-zealand
        "NZ123456783"
        "NZ3253395833"
        ;-- norway
        "NO12345"
        "NO123456789"
        "NO327583593"
        "NO123456789M"
        "NO327583593M"
        "NO123456789MA"
        "NO327583593MV"
        ;-- philippines
        "PH12345678901"
        "PH342583424"
        ;-- russia
        "RU11110100312"
        "RU11119222"
        "RU555511111"
        ;-- san-marino
        "SM1234113"
        "SM64"
        ;-- serbia
        "RS1294567"
        "RS1294567892"
        ;-- south africa
        "ZA50123456789"
        "ZA123466789O12"
        ;-- switzerland
        "CHE321231"
        "CHE123456788"
        "CHE123456788M"
        "CHE123456788VA"
        ;-- turkey
        "TR987654321"
        "TR234956846A3"
        ;-- ukraine
        "UA27418271"
        ;-- uzbekistan (invalid 0-1xx, 8-9xx)
        "UZ000000000"
        "UZ100000000"
        "UZ399999999"
        "UZ800000000"
        "UZ999999999"

        ; ----- unknown values...
        "qwertyuiop"
        "1111111111"
        "987654321"
        "pl987654321" 
        "XYZ"
    ]

    test-valid-vat: func [
        "Testing only valid VAT numbers"
    ] [
        foreach vat valid-vat-numbers [
            ; for debugging
            ;if (false == valid/vat vat) [
            ;    print rejoin [ "Failure: " vat ]
            ;]

            tester/assert-true valid/vat vat
        ]
    ]

    test-invalid-vat: func [
        "Testing incorrect VAT numbers"
    ] [
        foreach vat invalid-vat-numbers [
            ; for debugging
            ;if (true == valid/vat vat) [
            ;    print rejoin [ "Failure: " vat ]
            ;]

            tester/assert-false valid/vat vat
        ]
    ]
]

tester/run tests
