Red [
    Package: "Validator"
    Title: "Luhn validator"
    Description: "Luhn algorithm implementation for various digits"
    Author: "Mateusz Palichleb"
    File: %luhn.red
]

comment {
    Internal file as part of Validator tool

    Script based on:
    - https://en.wikipedia.org/wiki/Luhn_algorithm
}

context [
    /local digit: charset "0123456789"

    validate: func [
        "Is provided string a valid Luhn number?"
        luhn[string!]
        "Expected length of digits"
        quantity[integer!]
    ] [
        if (length? luhn) <> quantity [return false]

        unless parse luhn [quantity [digit]] [return false]

        return true
    ]
]
