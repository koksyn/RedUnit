Red [
    Title: "Tester"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %tester.red
    Version: "0.0.5"
]

do %tester/modules.red

tester: make tester-modules context [
    run: func [
        "Run all tests from provided object, should consist at least one test method"
        testable[object!]
    ] [
        buffer/clear
        buffer/put-line "--------- Tester ----------"
        buffer/put-line "Version 0.0.5^/"

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
    ]
]
