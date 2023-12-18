Red [
    Title: "POC Tests"
    Description: "Testing functionality of POC using RedUnit script"
    Author: "Mateusz Palichleb"
    File: %poc-tests.red
]

context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../../src/utils/poc.red
        point: context [ x:1 y:2 z:3 ]
    ]

    test-register-same-object-twice: func [
        "Registering same object twice should be possible"
    ] [
        poc/register "first" point
        poc/register "second" point
    ]

    test-register-same-name-twice: func [
        "Registering the same name twice is forbidden"
    ] [
        poc/register "twice" point

        redunit/expect-error
        poc/register "twice" point
    ]

    test-register-case-sensitive: func [
        "Registering case sensitive names should be possible"
    ] [
        poc/register "point" point
        poc/register "PoinT" point
    ]

    test-register-not-allowed-types: func [
        "Registering not allowed types will throw an error"
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

            redunit/expect-error
            poc/register name not-allowed-type
        ]
    ]

    test-was-registered: func [
        "Checking name was registered before and after registration"
    ] [
        redunit/assert-false poc/registered "my-point"
        poc/register "my-point" point
        redunit/assert-true poc/registered "my-point"
    ]

    test-replace-registered-name: func [
        "Replacing registered name should be possible"
    ] [
        poc/register "my-point" point
        poc/replace "my-point" point
    ]

    test-replace-unregistered-name: func [
        "Replacing unregistered name is forbidden"
    ] [
        redunit/expect-error
        poc/replace "unknown" point
    ]

    test-replace-multiple-times: func [
        "Replacing object multiple times should be possible"
    ] [
        poc/register "my-point" point

        poc/replace "my-point" point
        poc/replace "my-point" make object! [message: "ok"]
        poc/replace "my-point" point
        poc/replace "my-point" point
    ]

    test-resolve-registered-name: func [
        "Resolving registered name should be possible"
    ] [
        poc/register "my-point" point
        poc/resolve "my-point"
    ]

    test-resolve-unregistered-name: func [
        "Resolving unregistered name is forbidden"
    ] [
        redunit/expect-error
        poc/resolve "unknown" point
    ]

    test-resolve-returned-prototype-clone: func [
        "Resolving registered name should return Prototype clone"
    ] [
        poc/register "my-point" point
        result: poc/resolve "my-point"

        redunit/assert-equals point result
        redunit/assert-not-identical point result
    ]

    test-remove-registered-name: func [
        "Removing registered name should be possible"
    ] [
        poc/register "my-point" point
        redunit/assert-true poc/registered "my-point"

        poc/remove "my-point"
        redunit/assert-false poc/registered "my-point"
    ]

    test-remove-unregistered-name: func [
        "Removing unregistered name is forbidden"
    ] [
        redunit/expect-error
        poc/remove "unknown"
    ]
]