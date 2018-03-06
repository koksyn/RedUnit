Red [
    Title: "MAC validator tests"
    Description: "Testing functionality of MAC validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-mac-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/validator.red
    ]

    /local valid-mac-addresses: [
        "01:23:45:67:89:ab"
        "00:25:96:12:34:56"
        "01:23:45:67:89:AB"
        "01-23-45-67-89-ab"
        "01-23-45-67-89-AB"
        "00:0A:E6:3E:FD:E1"
        "00-15-E9-2B-99-3C"
        "00:09:3D:12:33:33"
        "0123.4567.89ab"
        "0123.4567.89AB"
    ]

    /local invalid-mac-addresses: [
        "01:23:45:67:89:aB"
        "01.23:45:67:89:ab"
        "GH:23:45:67:89:AB"
        "01-23-45-67-89"
        "01.23:45-67:89:FF"
        "01-23AB-67-89-AB"
        "0123.456789ab"
        "0123456789AB"
    ]

    test-valid-mac: func [
        "Testing only valid MAC addresses"
    ] [
        foreach mac valid-mac-addresses [
            ; for debugging
            ;if (false == valid/mac mac) [
            ;    print rejoin [ "Failure: " mac ]
            ;]

            tester/assert-true valid/mac mac
        ]
    ]

    test-invalid-mac: func [
        "Testing incorrect MAC addresses"
    ] [
        foreach mac invalid-mac-addresses [
            ; for debugging
            ;if (true == valid/mac mac) [
            ;    print rejoin [ "Failure: " mac ]
            ;]

            tester/assert-false valid/mac mac
        ]
    ]
]

tester/run tests
