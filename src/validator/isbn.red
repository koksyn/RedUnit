Red [
    Package: "Validator"
    Title: "ISBN validator"
    Description: "International Standard Book Number (ISBN) validation for 10 and 13 digits standard"
    Author: "Mateusz Palichleb"
    File: %isbn.red
]

comment {
    Internal file as part of Validator tool

    Script based on:
    - https://en.wikipedia.org/wiki/International_Standard_Book_Number
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
                probe isbn

                if bad-prefix isbn [ return false ]

                return parse isbn generate-isbn13-rule
            ]
            (length? isbn) == 10 [
                return parse isbn generate-isbn10-rule
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

    /local bad-prefix: func [
        "Checks the prefix of ISBN13 code is incorrect. Return logic!"
        code[string!]
    ] [
        return not parse code [
            "9" "7" ["8" | "9"]
            to end
        ]
    ]

    /local generate-isbn13-rule: does [
        return [dash] ;TODO

        ; LUHN algorithm here
    ]

    /local generate-isbn10-rule: does [
        iteration: 0
        sum: 0

        calculate-weight: [
            (weight: 10 - iteration)
        ]

        calculate-iteration: [
            (actual: to-integer actual)
            (sum: sum + (actual * weight))
            (iteration: iteration + 1)
        ]

        return [
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
                (sum: sum + (10 * weight))
                 ; ASCII integer! code
                (actual: ascii-to-integer actual)
            ]

            calculate-iteration

            if((sum % 11) == 0)
        ]
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
