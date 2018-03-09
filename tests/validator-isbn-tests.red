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
        "978-2-12-345680-3"
        "978-3-16-148410-0"
        "978-2-266-11156-0"
        "978-83-283-1401-6"
        "978-2-7605-1028-9"
        "978-83-283-0234-1"
        "978-88-8183-718-2"
        "978-83-7181-510-2"
        "888 18 3 7 1-88"
        "9788328314016"
        "9788328302341"
        "9788881837182"
        "9782266111560"
        "9782123456803"
        "9782760510289"
        "9780110002224"
        "2-7605-1028-X"
        "1-84356-028-3" ; English-speaking area
        "0-684-84328-5"
        "0-8044-2957-X"
        "0-85131-041-9"
        "0-943396-04-2"
        "0-9752298-0-X"
        "99921-58-10-7" ; Qatar
        "9971-5-0210-0" ; Singapore
        "960-425-059-0" ; Greece
        "80-902734-1-6" ; Czech Republic
        "85-359-0277-5" ; Brazil
        "2266111566"
        "2123456802"
        "8881837188"
        "9971502100"
    ]

    /local invalid-isbn-numbers: [
        "978-3-16-148410-X"
        "978-88-8183-7-1-8-8"
        "9788881837186"
        "9782266111561"
        "978226611156"
        "undefined1"
        "1234567890"
        "123456789A"
        "123456789"
    ]

    test-valid-isbn: func [
        "Testing only valid ISBN numbers"
    ] [
        foreach isbn valid-isbn-numbers [
            ; for debugging
            ;if (false == valid/isbn isbn) [
            ;    print rejoin [ "Failure: " isbn ]
            ;]

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