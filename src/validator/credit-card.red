Red [
    Package: "Validator"
    Title: "Credit Card number validator"
    Description: "Checking valid Credit Card numbers using Luhn algorithm"
    Author: "Mateusz Palichleb"
    File: %credit-card.red
]

; Internal file as part of Validator tool

context [
    /local whitespace: charset reduce [space tab cr lf]
    /local digit: charset "0123456789"
    /local luhn: do %luhn.red

    validate: func [
        "Is provided string a valid Credit Card number?"
        cc[string!]
    ] [
        remove-whitespaces cc
        
        return luhn/validate cc
    ]

    /local remove-whitespaces: func [
        "Removes all whitespaces from provided subject"
        subject[string!]
    ] [
        parse subject [any [to whitespace change whitespace ""]]
    ]
]