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

x: context [
    /local digit: charset "0123456789"

    validate2: func [
        "Is provided string a valid Luhn number?"
        luhn[string!]
        "Expected length of digits"
        quantity[integer!]
    ] [
        forbidden-input: 
            (quantity < 2) or 
            ((length? luhn) <> quantity) or
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

        print luhn

        return (sum % 10) == 0
    ]

    validate: func [
        "Is provided string a valid Luhn number?"
        luhn[string!]
        "Expected length of digits"
        quantity[integer!]
    ] [
        if (length? luhn) <> quantity [return false]

        unless parse luhn [quantity [digit]] [return false]

        sum: 0
        iteration: 1

        while [iteration < quantity] [
            actual: to integer! (copy/part at luhn iteration 1)

            ;print rejoin ["Act: " actual]

            if (iteration % 2) == 0 [
                actual: (3 * actual)
            ]

            ;print rejoin ["'" actual "' "]

            sum: sum + actual
            iteration: iteration + 1
        ]

        ;print rejoin ["Sum: " sum]

        mo: (sum % 10)

        ;print rejoin ["Modulo: " mo]

        if mo <> 0 [
            mo: 10 - mo
        ]

        ;print rejoin ["Check digit: " mo]

        last-digit: to integer! (copy/part at luhn iteration 1)

        return mo == last-digit
    ]
]
comment {
probe x/validate "9788881837182" 13

print "----- true -----"

probe x/validate "9788881837182" 13 ;t
probe x/validate "9782266111560" 13 ;t
probe x/validate "9780008" 7
probe x/validate "9780016" 7
probe x/validate "9780024" 7
probe x/validate "9780032" 7
probe x/validate "9780040" 7
probe x/validate "9780057" 7
probe x/validate "9780065" 7
probe x/validate "9780073" 7
probe x/validate "9780081" 7
probe x/validate "9780099" 7
probe x/validate "9780107" 7
probe x/validate "9780115" 7

probe x/validate "102033032" 9
probe x/validate "102033131" 9
probe x/validate "102033230" 9
probe x/validate "102033339" 9

probe x/validate "539" 3
probe x/validate "67" 2

print "----- false -----"
probe x/validate "9788328302341" 13 ; f
probe x/validate "9788328314016" 13 ; f
probe x/validate "9782123456803" 13 ; f
probe x/validate "9782760510289" 13 ; f

probe x/validate "" 13
probe x/validate "1133111" 4
probe x/validate "123" 4
probe x/validate "1" 2
probe x/validate "6" 1
probe x/validate "5" 1}

x