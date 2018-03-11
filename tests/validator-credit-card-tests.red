Red [
    Title: "Credit Card validator tests"
    Description: "Testing functionality of Credit Card validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-credit-card-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        luhn: do %../src/validator.red
    ]

    /local valid-cc-numbers: [
        "3782 822463 10005" ; American Express
        "3714 496353 98431" ; American Express
        "4242 4242 4242 4242" ; Visa
        "5555 5555 5555 4444" ; Mastercard
        "2223 0031 2200 3222" ; Mastercard
        "6200 0000 0000 0005" ; UnionPay
        "3852 0000 0232 37" ; Diners Club
        "3056 9309 0259 04" ; Diners Club
        "6011 0009 9013 9424" ; Discover
        "6011 1111 1111 1117" ; Discover
        "4000 0566 5566 5556" ; Visa - debit
        "5200 8282 8282 8210" ; Mastercard - debit
        "5105 1051 0510 5100" ; Mastercard - prepaid
        "3530 1113 3330 0000" ; JCB
        "6799990100000000019"
        "6271136264806203568"
        "6759649826438453"
        "6334000000000004"
        "6304100000000008"
        "6011000000000004" 
        "6007220000000004"
        "5500000000000004"
        "5019717010103742" 
        "4917300800000000"
        "4903010000000009" 
        "4111111111111111"
        "2131000000000008"
        "340000000000009" 
        "201400000000009" 
        "38520000023237"  
        "30000000000004"
    ]

    /local invalid-cc-numbers: [
        "63340001200701001"
        "4111111111111112"
        "3852000002323"
        "3852000023237"
        "odyniec"
        "13131"
        "124"
        "123"
    ]

    test-valid-credit-cards: func [
        "Testing only valid Credit Card numbers"
    ] [
        foreach cc valid-cc-numbers [
            ; for debugging
            ;if (false == valid/credit-card cc) [
            ;    print rejoin [ "Failure: " cc ]
            ;]

            tester/assert-true valid/credit-card cc
        ]
    ]

    test-invalid-credit-cards: func [
        "Testing incorrect Credit Card numbers"
    ] [
        foreach cc invalid-cc-numbers [
            ; for debugging
            ;if (true == valid/credit-card cc) [
            ;    print rejoin [ "Failure: " cc ]
            ;]

            tester/assert-false valid/credit-card cc
        ]
    ]
]

tester/run tests