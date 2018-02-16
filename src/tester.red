Red [
    Title: "Tester"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %tester.red
    Version: "0.0.4"
]

do %tester-string-buffer.red

tester: context [
    /local errors: make map![]
    /local setup-detected: false
    /local error-expected: false
    /local actual-test-name: ""
    /local buffer: tester-string-buffer

    run: func [
        "Run all tests from provided object, should consist at least one test method"
        testable[object!]
    ] [
        buffer/clear
        buffer/put-line "--------- Tester ----------"
        buffer/put-line "Version 0.0.4^/"

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

    ;------------------------ INTERNAL METHODS -------------------------
    ;-- Please do not use them outside this script!

    /local process-testable-methods: func [
        "Will detect 'setup' and 'test***' methods - and prepare them to execution"
        testable[object!]
    ] [
        setup-detected: false
        tests: []
                
        methods: words-of testable   

        foreach method methods [
            method-name: to string! method

            case [
                method-name = "setup" [
                    setup-detected: true
                ]
                find method-name "test" [
                    insert tests method
                ]
            ]
        ]

        if (length? tests) = 0 [
            print "[Error] Provided object does not have any test method!"
            halt
        ]

        tests
    ]

    /local execute-test: func [
        "Executes one test method"
        test
    ] [
        buffer/put rejoin ["[test] " test " "]

        ; reset context of expected error for each test
        error-expected: false
        ; define actually executed test name
        actual-test-name: to string! test

        errors-before: length? errors
        
        was-error: error? result: try [
            do test
        ]

        case [
            was-error and (not error-expected) [
                put errors test result
            ]
            (not was-error) and error-expected [
                message: "Expected error, but nothing happen."
                fail-test message "error-expected"
            ]
        ]
        
        errors-after: length? errors

        either errors-before <> errors-after [
            buffer/put-line "[Failure]"
        ] [
            buffer/put-line "[Success]"
        ]
    ]

    /local show-execution-time: func [
        "Print interval of execution time (in seconds) in Console"
        started[time!] ended[time!]
    ] [
        interval: to float! ended - started

        buffer/put-line rejoin ["^/Execution time: " interval " sec"] 
    ]

    ;-- Print all catched errors in Console
    /local show-catched-errors: does [
        were-errors: (length? errors) > 0

        if were-errors [
            buffer/put-line "^/---- Errors ----^/"

            keys: reflect errors 'words
            foreach key keys [
                buffer/put-line rejoin [key ":^/" select errors key "^/"]
            ]
        ]
    ]

    /local fail-test: func [
        "Cause actual test failure - internally from assertions"
        message[string!] assertion[string!]
    ] [
        issue: make error! [
            code: none
            type: 'user
            id: 'message
            arg1: message
            where: append "assert-" assertion
        ]

        issue-number: (length? errors) + 1
        issue-key: rejoin [actual-test-name "-" assertion "-" issue-number]

        put errors issue-key issue
    ]

    ;------------------------ ASSERTIONS -------------------------
    ;-- You can use this methods to test your code

    expect-error: does [
        "Mark that actually executed test should throw an error. Other tests will not be affected."
        error-expected: true
    ]

    assert-true: func [
        "Value is true?"
        value[logic!] 
    ] [
        if not value [
            message: "Expected value was 'true', but 'false' given."
            fail-test message "true"
        ]
    ]

    assert-false: func [
        "Value is false?"
        value[logic!] 
    ] [
        if value [
            message: "Expected value was 'false', but 'true' given."
            fail-test message "false"
        ]
    ]

    assert-equals: func [
        "Does arguments have the same data?"
        expected actual
    ] [
        different-data: not (strict-equal? expected actual)
        
        if different-data [
            message: "Expected equivalent values, but they are different."
            fail-test message "equals"
        ]
    ]

    assert-not-equals: func [
        "Does arguments have a different data?"
        expected actual
    ] [
        same-data: strict-equal? expected actual
        
        if same-data [
            message: "Expected different values, but they are equivalent."
            fail-test message "not-equals"
        ]
    ]

    assert-identical: func [
        "Does arguments have identical addresses in memory?"
        expected actual
    ] [
        different-memory-location: not (same? expected actual)
        
        if different-memory-location [
            message: "Expected identical values, regarding memory location, but they are different."
            fail-test message "identical"
        ]
    ]

    assert-not-identical: func [
        "Does arguments have different addresses in memory?"
        expected actual
    ] [
        identical-memory-location: same? expected actual
        
        if identical-memory-location [
            message: "Expected different values, regarding memory location, but they are identical."
            fail-test message "not-identical"
        ]
    ]
]
