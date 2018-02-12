Red [
    Title: "Inversion of Control container for Red Lang"
    Author: "Mateusz Palichleb"
    File: %ioc-container.red
]

ioc: context [
    registry: make map![]

    register: func [
        "Put object to container, identified by name"
        name[string!] prototype[object!]
    ] [
        put registry name prototype
    ]

    registered: func [
        "Check, that identifier is already registered"
        name[string!]
    ] [
        identifiers: words-of registry
        foreach identifier identifiers [
            result: identifier = name
            if result [break]
        ]

        result
    ]

    resolve: func [
        "Get object from container by name"
        name[string!]
    ] [
        if not registered name [
            cause-error 'user 'message [
                append "You can not call unregistered: " name
            ]
        ]

        prototype: select registry name
        make prototype []
    ]
]

do ""

; Example1: A book with ISBN
; --------------------------
; 
;     ISBN: "999-8-76-543210-1"
;     book: object [title: "Red cookbook"]
;
;     ioc/register ISBN book
;     result: ioc/resolve ISBN
;
;     print result/title
;     == "Red cookbook"
;
; Example 2: Causing errors
; --------------------------
; 
;     ioc/resolve "unknown-identifier"
;     *** User Error: "You can not call unregistered: unknown-identifier"
;     *** Where: do
;     *** Stack: cause-error
;
; Example 3: Handling errors
; --------------------------
; 
;     either error? result: try [ioc/resolve "unknown-identifier"] [
;         print ["Error message: " result/arg1]
;     ] [
;         print ["We've got it! " result]
;     ]
;
