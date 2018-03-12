Red [
    Package: "Validator"
    Title: "ISBN validator"
    Description: "International Standard Book Number (ISBN) validation for 10 and 13 digits standard"
    Author: "Mateusz Palichleb"
    File: %isbn.red
]

comment {
    Internal file as part of Validator tool
    Script based on: https://en.wikipedia.org/wiki/International_Standard_Book_Number
}

context [
    /local whitespace: charset reduce [space tab cr lf]
    /local digit: charset "0123456789"
    /local x-letter: charset "xX"
    /local x-digit: union digit x-letter
    /local dash: charset "-‐"

    validate: func [
        "Is provided string a valid ISBN number?"
        isbn[string!]
    ] [
        if (empty? isbn) [return false]

        remove-whitespaces isbn
        remove-dashes isbn

        case [
            (length? isbn) == 13 [
                return validate-isbn13 isbn
            ]
            (length? isbn) == 10 [
                return validate-isbn10 isbn
            ]
        ]

        return false
    ]

    /local remove-whitespaces: func [
        "Removes all whitespaces from provided subject"
        subject[string!]
    ] [
        parse subject [any [to whitespace change whitespace ""]]
    ]

    /local remove-dashes: func [
        "Removes all dashes and hyphens from provided subject"
        subject[string!]
    ] [
        parse subject [any [to dash change dash ""]]
    ]

    /local validate-isbn13: func [
        "Validates 13-digit ISBN number"
        isbn[string!]
    ] [
        bad-prefix: not parse isbn ["9" "7" ["8"|"9"] to end]
        only-digits: parse isbn [13 [digit]]

        if bad-prefix or (not only-digits) [return false]
        
        checksum: 0
        iteration: 1

        while [iteration < 13] [
            current-digit: to integer! (copy/part at isbn iteration 1)

            if (iteration % 2) == 0 [
                current-digit: (3 * current-digit)
            ]

            checksum: checksum + current-digit
            iteration: iteration + 1
        ]

        last-digit: to integer! (at tail isbn -1)

        ; calculating check digit
        check-digit: (checksum % 10)
        if check-digit <> 0 [
            check-digit: 10 - check-digit
        ]

        return check-digit == last-digit
    ]

    /local validate-isbn10: func [
        "Validates 10-digit ISBN number"
        isbn[string!]
    ] [
        iteration: 0
        checksum: 0

        calculate-weight: [
            (weight: 10 - iteration)
        ]

        calculate-iteration: [
            (actual: to-integer actual)
            (checksum: checksum + (actual * weight))
            (iteration: iteration + 1)
        ]

        rule: [
            9 [
                copy actual digit 
                calculate-weight
                calculate-iteration
            ]
            
            copy actual x-digit 
            calculate-weight
            (actual: uppercase actual)
            
            any [
                if(actual == "X") 
                (checksum: checksum + (10 * weight))
                 ; ASCII integer! code
                (actual: ascii-to-integer actual)
            ]

            calculate-iteration

            if((checksum % 11) == 0)
        ]

        return parse isbn rule
    ]

    /local ascii-to-integer: func [
        "Converts ASCII character to integer!"
        ascii[string!]
    ] [
        case [
            (empty? ascii) [
                cause-error 'user 'message "Cannot convert empty ASCII string to integer" 
            ]
            (length? ascii) > 1 [
                cause-error 'user 'message "Only one character is allowed" 
            ]
        ]
        
        ascii-char: to char! ascii

        return to integer! ascii-char
    ]
]
