Red [
    Title: "VAT EU validator tests"
    Description: "Testing functionality of VAT EU validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %valid-vat-eu-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/valid-vat-eu.red
    ]
    
    test-hungary-valid-vat: does [
        vat-numbers: ["HU12345678" "HU87654321" "HU33344455"]

        foreach vat vat-numbers [
            tester/assert-true valid-vat-eu/check vat
        ]
    ]

    test-hungary-invalid-vat: does [
        vat-numbers: ["HU1" "HU123" "HU123456"]
        
        foreach vat vat-numbers [
            tester/assert-false valid-vat-eu/check vat
        ]
    ]

    test-poland-valid-vat: does [
        vat-numbers: [
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
        ]

        foreach vat vat-numbers [
            tester/assert-true valid-vat-eu/check vat
        ]
    ]

    test-poland-invalid-vat: does [
        vat-numbers: [
            "PL1234567890"
            "PL0987654321"
            "PL1234543211"
            "PL0987656789"
            "PL1111111112"
            "PL2222222221"
            "PL000000001"
            "PL12332113"
            "PLQWERTYUIOP"
            "PL123"
            "1233211232" ; number invalid for PL + invalid country code
            "9924161648" ; number valid for PL + invalid country code
        ]

        foreach vat vat-numbers [
            tester/assert-false valid-vat-eu/check vat
        ]
    ]
]

tester/run tests