Red [
    Title: "SEDOL validator tests"
    Description: "Testing functionality of SEDOL validator using Tester script"
    Author: "Mateusz Palichleb"
    File: %validator-sedol-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/validator.red
    ]

    /local valid-sedol-numbers: [
        "B0YBKJ7"
        "B0YBLH2"
        "B0YBKL9"
        "B0YBKT7"
        "B0WNLY7"
        "B0YBKR5"
        "B000300"
        "7108899"
        "5579107"
        "5852842"
        "4065663"
        "2282765"
        "0263494"
    ]

    /local invalid-sedol-numbers: [
        "71-08-899"
        "710 889"
        "7108899X"
        "0123456" 
        "B0WWWWF"
    ]

    test-valid-sedol: func [
        "Testing only valid SEDOL numbers"
    ] [
        foreach sedol valid-sedol-numbers [
            ; for debugging
            ;if (false == valid/sedol sedol) [
            ;    print rejoin [ "Failure: " sedol ]
            ;]

            tester/assert-true valid/sedol sedol
        ]
    ]

    test-invalid-sedol: func [
        "Testing incorrect SEDOL numbers"
    ] [
        foreach sedol invalid-sedol-numbers [
            ; for debugging
            ;if (true == valid/sedol sedol) [
            ;    print rejoin [ "Failure: " sedol ]
            ;]

            tester/assert-false valid/sedol sedol
        ]
    ]
]

tester/run tests