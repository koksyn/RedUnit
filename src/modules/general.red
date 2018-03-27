Red [
    Package: "RedUnit"
    Title: "General module"
    Description: "Public interface, to be used globally."
    Author: "Mateusz Palichleb"
    File: %general.red
]

;-- You can use that to run an object! with tests



comment {
; Temporary solution for running all tests at once,
; until RedUnit will have this functionality in further releases

tester: do %src/tester.red
files: read %tests/
all-tests: context []

foreach file files [	
    if find file "-tests.red" [
        test-file-path: rejoin ["tests/" file]
        ;print rejoin [ "^/>> " test-file-path "^/"]

        test-file: to file! test-file-path

        tests: do test-file
        all-tests: make all-tests tests
    ]
]

change-dir %tests
tester/run all-tests
change-dir %..
}

context [
    prefix: ""
    postfix: "-tests"

    run: func [
        "Will detect and execute all '<prefix>***<postfix>.red' test objects under '<dir>' directory"
        dir[file!]
    ] [
        probe dir
        probe prefix
        probe postfix
    ]

    run-single: func [
        "Run all tests from provided object (loaded from filepath), which should consist at least one test method"
        filepath[file!]
    ] [
        ; remember paths
        boot-dir: what-dir
        code-dir: pick (split-path filepath) 1

        ; load testable file
        code: read filepath
        change-dir code-dir
        testable: do code

        buffer/clear
        buffer/putline "--------- RedUnit ----------"
        buffer/putline "Version 0.0.1^/"
        
        process-testable-methods testable
        
        started: now/time/precise/utc

        foreach test tests [
            if setup-detected [do testable/setup]
            execute-test test
        ]

        ended: now/time/precise/utc

        ; revert boot directory
        change-dir boot-dir

        show-execution-time started ended
        show-catched-errors

        buffer/put "---------------------------"
        print buffer/flush

        ; EXIT codes for continuous integration
        quit-when-errors
    ]
]