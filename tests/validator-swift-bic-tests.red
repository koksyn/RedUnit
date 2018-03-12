Red [
    Title: "SWIFT/BIC validator tests"
    Description: "Testing functionality of SWIFT/BIC validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-swift-bic-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/validator.red
    ]

    /local valid-swift-bic-addresses: [
        "CEDELULLXXX"
        "GENODEF1JEV"
        "UBSWCHZH80A"
        "RZTIAT22263"
        "BCEELULL"
        "MARKDEFF"
        "RBOSGGSX"
    ]

    /local invalid-swift-bic-addresses: [
        "CE1EL2LLFFF"
        "E31DCLLFFF"
        "BCE3LU1L"
        "MARK-DEF1"
        "RBOS GGSX"
    ]

    test-valid-swift-bic: func [
        "Testing only valid swift-bic addresses"
    ] [
        foreach swift-bic valid-swift-bic-addresses [
            ; for debugging
            ;if (false == valid/swift-bic swift-bic) [
            ;    print rejoin [ "Failure: " swift-bic ]
            ;]

            tester/assert-true valid/swift-bic swift-bic
        ]
    ]

    test-invalid-swift-bic: func [
        "Testing incorrect swift-bic addresses"
    ] [
        foreach swift-bic invalid-swift-bic-addresses [
            ; for debugging
            ;if (true == valid/swift-bic swift-bic) [
            ;    print rejoin [ "Failure: " swift-bic ]
            ;]

            tester/assert-false valid/swift-bic swift-bic
        ]
    ]
]

tester/run tests
