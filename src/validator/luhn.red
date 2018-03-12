Red [
    Package: "Validator"
    Title: "Luhn validator"
    Description: "Luhn algorithm implementation for various digits"
    Author: "Mateusz Palichleb"
    File: %luhn.red
]

comment {
    Internal file as part of Validator tool
    Script based on: https://en.wikipedia.org/wiki/Luhn_algorithm
}

context [
    /local digit: charset "0123456789"

    validate: func [
        "Is provided string a valid Luhn number?"
        luhn[string!]
    ] [
        quantity: length? luhn

        forbidden-input: 
            (quantity < 2) or 
            (not parse luhn [quantity [digit]])
        
        if forbidden-input [return false]

        sum: 0
        iteration: quantity
        reversed: false

        while [iteration > 0] [
            calculated: to integer! (copy/part at luhn iteration 1)

            if reversed [
                calculated: calculated * 2

                if calculated > 9 [
                    calculated: calculated - 9
                ]
            ]

            sum: sum + calculated
            reversed: not reversed
            iteration: iteration - 1
        ]

        return (sum % 10) == 0
    ]
]