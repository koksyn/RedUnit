Red [
    Package: "Validator"
    Title: "SEDOL validator"
    Description: "Stock Exchange identifiers used in the United Kingdom and Ireland"
    Author: "Mateusz Palichleb"
    File: %sedol.red
]

comment {
    Internal file as part of Validator tool
    Script based on: https://en.wikipedia.org/wiki/SEDOL
}

context [
    /local digit: charset "0123456789"
    /local sedol-letters: charset "BCDFGHJKLMNPQRSTVWXYZ"
    /local sedol-charset: union digit sedol-letters

    validate: func [
        "Is provided string a valid SEDOL code?"
        sedol[string!]
    ] [
        forbidden-input: 
            (empty? sedol) or 
            ((length? sedol) <> 7) or
            (not parse sedol [6 [sedol-charset] digit])

        if forbidden-input [return false]

        sedol: uppercase sedol
        weights: [1 3 1 7 3 9 1]
        checksum: 0
        iteration: 1

        while [iteration <= 6] [
            weight: pick weights iteration
            current: copy/part at sedol iteration 1
            current: base36-to-integer current

            checksum: checksum + (weight * current)
            iteration: iteration + 1
        ]

        check-digit: (10 - (checksum % 10)) % 10
        last-digit: to integer! (at tail sedol -1)

        return last-digit == check-digit
    ]

    ; based on https://www.stum.de/2008/10/20/base36-encoderdecoder-in-c/
    /local base36-to-integer: func [
        "Converts BASE-36 encoded string into a integer!"
        base36[string!]
    ] [
        charlist: "0123456789abcdefghijklmnopqrstuvwxyz"
        reversed: reverse lowercase base36
        result: 0
        position: 0

        foreach char reversed [
            index: index? find charlist char
            calculated: (index - 1) * (power 36 position)
            result: result + calculated
            position: position + 1
        ]

        return result
    ]
]
