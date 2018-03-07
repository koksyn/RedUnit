Red [
    Title: "ISBN validator tests"
    Description: "Testing functionality of ISBN validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-isbn-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/validator.red
    ]

    /local valid-isbn-numbers: [
            "888 18 3 7 1-88"
            "978-83-283-1401-6"
            "2-7605-1028-X"
            "978-83-283-0234-1"
            "9788328302341"
            "978-88-8183-718-2"
            "978-2-266-11156-0"
            "9788328314016"
            "978-2-12-345680-3"
            "978-88-8183-718-2"
            "978-2-7605-1028-9"
            "2266111566"
            "2123456802"
            "8881837188"
    ]

    /local invalid-isbn-numbers: [
        "01:23:45:67:89:aB"
        "01.23:45:67:89:ab"
        "GH:23:45:67:89:AB"
        "01-23-45-67-89"
        "01.23:45-67:89:FF"
        "01-23AB-67-89-AB"
        "0123.456789ab"
        "0123456789AB"
    ]

    test-valid-isbn: func [
        "Testing only valid ISBN numbers"
    ] [
        foreach isbn valid-isbn-numbers [
            ; for debugging
            if (false == valid/isbn isbn) [
                print rejoin [ "Failure: " isbn ]
            ]

            tester/assert-true valid/isbn isbn
        ]
    ]

    test-invalid-isbn: func [
        "Testing incorrect ISBN numbers"
    ] [
        foreach isbn invalid-isbn-numbers [
            ; for debugging
            ;if (true == valid/isbn isbn) [
            ;    print rejoin [ "Failure: " isbn ]
            ;]

            tester/assert-false valid/isbn isbn
        ]
    ]
]

tester/run tests
