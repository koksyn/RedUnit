Red [
    Title: "Tester"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %tester.red
    Version: "0.0.1"
]

tester: context [
    /local tests-passed: 0
    /local errors: make series![]
    /local execute-setup: false

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
	    passed-before: tests-passed

            if execute-setup [
                do testable/setup
            ]

            do test
	    
            either passed-before <> tests-passed [
                print "[Success]"
            ] [
                print "[Failure]"
            ]
        ]

        end-time: now/time/precise/utc

        diff: to float! end-time - start-time
        print rejoin ["^/Execution time: " diff " sec"] 
	print "---------------------------"
    ]

    assert-true: func [
        value[logic!] error 
    ] [
        either value [
            tests-passed: tests-passed + 1
        ] [
            put errors error
        ]
    ]

    print-title: does [
        print "--------- Tester ----------"
        print "Version 0.0.1^/"
    ]
]
