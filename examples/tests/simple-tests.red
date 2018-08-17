Red [
    Title: "Simple Tests"
    Description: "Testing functionality of simple tasks"
    Author: "Mateusz Palichleb"
    File: %simple-tests.red
]

context [
    test-different-values: func [
        "Checking different values"
    ] [
        redunit/assert-not-equals 1 2
    ]

    test-error-thrown: func [
        "Expecting error"
    ] [
        redunit/expect-error
        x: 1 / 0
    ]
]