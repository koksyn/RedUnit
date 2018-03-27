Red [
    Title: "Simple Tests"
    Description: "Testing functionality of simple tasks"
    Author: "Mateusz Palichleb"
    File: %simple-tests.red
]

context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        point: context [ x:1 y:2 ]
    ]

    test-different-values: func [
        "Checking different values"
    ] [
        redunit/assert-not-equals point/x point/y
    ]

    test-error-thrown: func [
        "Expecting error"
    ] [
        redunit/expect-error
        point/z
    ]
]