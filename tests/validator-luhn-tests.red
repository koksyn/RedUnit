Red [
    Title: "Luhn validator tests"
    Description: "Testing functionality of Luhn validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-luhn-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        luhn: do %../src/validator/luhn.red
    ]

    /local valid-luhn-numbers: [
        "9788881837182"
        "9782266111560"
        "102033032"
        "102033131"
        "102033230"
        "102033339"
        "9780008"
        "9780016"
        "9780024"
        "9780032"
        "9780040"
        "9780057"
        "9780065"
        "9780073"
        "9780081"
        "9780099"
        "9780107"
        "9780115"
        "539"
        "67"
    ]

    /local invalid-luhn-numbers: [
        "9788328302341"
        "9788328314016"
        "9782123456803"
        "9782760510289"
        "1133111"
        "123"
        "1"
        "6"
        "5"
        "" ; also behaviour for empty string should be tested
    ]

    test-valid-luhn: func [
        "Testing only valid Luhn numbers"
    ] [
        foreach text valid-luhn-numbers [
            ; for debugging
            ;if (false == luhn/validate text) [
            ;    print rejoin [ "Failure: " text ]
            ;]

            tester/assert-true luhn/validate text
        ]
    ]

    test-invalid-luhn: func [
        "Testing incorrect Luhn numbers"
    ] [
        foreach text invalid-luhn-numbers [
            ; for debugging
            ;if (true == luhn/validate text) [
            ;    print rejoin [ "Failure: " text ]
            ;]

            tester/assert-false luhn/validate text
        ]
    ]
]

tester/run tests