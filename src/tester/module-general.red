Red [
    Package: "Tester"
    Title: "General module"
    Description: "Public interface, to be used globally."
    Author: "Mateusz Palichleb"
    File: %module-general.red
]

;-- You can use that to run an object! with tests

context [
    run: func [
        "Run all tests from provided object, which should consist at least one test method"
        testable[object!]
    ] [
        buffer/clear
        buffer/putline "--------- Tester ----------"
        buffer/putline "Version 0.0.6^/"

        tests: process-testable-methods testable
        
        started: now/time/precise/utc

        foreach test tests [
            if setup-detected [do testable/setup]
            execute-test test
        ]

        ended: now/time/precise/utc

        show-execution-time started ended
        show-catched-errors

        buffer/put "---------------------------"
        print buffer/flush

        ; EXIT codes for continuous integration
        quit-when-errors
    ]
]
