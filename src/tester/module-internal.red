Red [
    Package: "Tester"
    Title: "Internal"
    Description: "Internal methods and fields for Tester tool."
    Purpose: "Encapsulating internal source of Tester."
    Author: "Mateusz Palichleb"
    File: %module-internal.red
]

;-- Please do NOT use that in your tests

context [
    /local errors: make map![]
    /local setup-detected: false
    /local error-expected: false
    /local actual-test-name: ""
    /local buffer: do %string-buffer.red

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
                find/case method-name "test" [
                    insert tail tests method
                ]
            ]
        ]

        if (length? tests) = 0 [
            print "[Error] Provided object does not have any test method!"
            halt
        ]

        return tests
    ]

    /local execute-test: func [
        "Executes one test method"
        test
    ] [
        buffer/put rejoin ["[test] " test " "]

        ; reset context of expected error for each test
        error-expected: false
        result: none
        ; define actually executed test name
        actual-test-name: to string! test

        errors-before: length? errors

        was-error: none? attempt [ 
            result: try [do test] 
        ]

        unless none? result [
            case [
                was-error and (not error-expected) [
                    put errors test result
                ]
                (not was-error) and error-expected [
                    message: "Expected error, but nothing happen."
                    fail-test message "error-expected"
                ]
            ]
        ]

        errors-after: length? errors

        either errors-before <> errors-after [
            buffer/putline "[Failure]"
        ] [
            buffer/putline "[Success]"
        ]
    ]

    /local show-execution-time: func [
        "Print interval of execution time (in seconds) in Console"
        started[time!] ended[time!]
    ] [
        interval: to float! ended - started

        buffer/putline rejoin ["^/Execution time: " interval " sec"] 
    ]

    ;-- Print all catched errors in Console
    /local show-catched-errors: does [
        were-errors: (length? errors) > 0

        if were-errors [
            buffer/putline "^/---- Errors ----^/"

            keys: reflect errors 'words
            foreach key keys [
                buffer/putline rejoin [key ":^/" select errors key "^/"]
            ]
        ]
    ]

    ;-- Returns EXIT CODE 1 - when there were some failed tests 
    /local quit-when-errors: does [
        if (length? errors) > 0 [
            quit-return 1
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
]
