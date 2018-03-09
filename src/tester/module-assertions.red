Red [
    Package: "Tester"
    Title: "Assertions"
    Description: "Available assertions to test your code."
    Purpose: "Registering errors from failed assertions"
    Author: "Mateusz Palichleb"
    File: %module-assertions.red
]

;-- You can use this assertions to test your code

context [
    expect-error: does [
        "Mark that actually executed test should throw an error. Other tests will not be affected."
        error-expected: true
    ]

    assert-true: func [
        "Value is true?"
        value[logic!] 
    ] [
        unless value [
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
