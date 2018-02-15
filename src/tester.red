Red [
    Title: "Tester"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %tester.red
    Version: "0.0.2"
]

tester: context [
    /local tests-passed: 0
    /local errors: make map![]
    /local execute-setup: false
    /local error-expected: false
    /local actual-test-name: ""

    run: func [
        testable[object!]
    ] [
        print-title

        methods: words-of testable

        tests: []
        
        foreach method methods [
	    method-name: to string! method

            if method-name = "setup" [
                execute-setup: true
            ]

	    test-method: find method-name "test"
            if test-method [
                insert tests method
            ]
        ]

        start-time: now/time/precise/utc

        foreach test tests [
	        prin rejoin ["[test] " test " "]
	        errors-before: length? errors
            error-expected: false
            actual-test-name: to string! test

            if execute-setup [
                do testable/setup
            ]

            was-error: error? result: try [
                do test
            ]

            case [
                was-error and (not error-expected) [
                    put errors test result
                ]
                (not was-error) and error-expected [
                    size: length? errors
                    issue: make error! [
                        code: none
                        type: 'user
                        id: 'message
                        arg1: "Expected error, but nothing happen."
                        where: 'expect-error
                    ]
                    assertion: rejoin [actual-test-name "-error-expected-"]
                    key: append assertion size
                    put errors key issue
                ]
                true [
                    tests-passed: tests-passed + 1
                ]
            ]
            
	        errors-after: length? errors
            either errors-before <> errors-after [
                print "[Failure]"
            ] [
                print "[Success]"
            ]
        ]

        end-time: now/time/precise/utc

        diff: to float! end-time - start-time
        print rejoin ["^/Execution time: " diff " sec"] 

        errors-count: length? errors
	    if errors-count > 0 [
            print "^/---- Errors ----^/"

            keys: reflect errors 'words
            foreach key keys [
                print rejoin [key ":^/" select errors key "^/"]
            ]
        ]
	    print "---------------------------"
    ]

    assert-true: func [
        value[logic!] 
    ] [
        either value [
            tests-passed: tests-passed + 1
        ] [
            size: length? errors
            issue: make error! [
                code: none
                type: 'user
                id: 'message
                arg1: "Expected value was 'true', but 'false' given."
                where: 'assert-true
            ]
            assertion: rejoin [actual-test-name "-assert-true-"]
            key: append assertion size
            put errors key issue
        ]
    ]

    assert-false: func [value[logic!]] [assert-true not value]

    expect-error: does [
        error-expected: true
    ]

    print-title: does [
        print "--------- Tester ----------"
        print "Version 0.0.2^/"
    ]
]
