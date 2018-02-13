Red [
    Title: "POC Tests"
    Description: "Testing functionality of POC using Tester script"
    Author: "Mateusz Palichleb"
    File: %poc-tests.red
]

do %../src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../src/poc.red
    ]

    test-add-not-allowed-types: func [
        "Test register an not allowed types will throw an error"
    ] [
        not-allowed-types: [
            "string" 
            ["list"]
            1234
            email@address.com
            true
            false
            none
            ""
        ]

        counter: 1
	foreach not-allowed-type not-allowed-types [
            name: append "name-" counter
            counter: counter + 1

            was-error: error? result: try [
                poc/register name not-allowed-type
            ]

            tester/assert-true was-error result
        ]
    ]
]

tester/run tests
