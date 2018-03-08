Red [
    Package: "Validator"
    Title: "48-bit MAC address validator"
    Description: "The media access control (MAC) address is a unique identifier assigned to network interface controllers"
    Author: "Mateusz Palichleb"
    File: %mac.red
]

comment {
    Internal file as part of Validator tool

    Script based on:
    - http://en.wikipedia.org/wiki/MAC_address#Notational_conventions

    Compatible with IEEE 802 standard and other conventions
}

context [
    /local whitespace: charset reduce [space tab cr lf]
    /local digit: charset "0123456789"
    /local x: charset "xX"
    /local x-digit: union x digit
    /local dash: charset "-‐"

    validate: func [
        "Is provided string a valid ISBN number?"
        isbn[string!]
    ] [
        if (empty? isbn) [return false]

        before: copy isbn
        remove-whitespaces isbn
        remove-dashes isbn

        case [
            (length? isbn) == 13 [
                print "--- 13 ---"
                probe before
                probe isbn

                return parse isbn generate-isbn13-rule
            ]
            (length? isbn) == 10 [
                print "--- 10 ---"
                probe before
                probe isbn

                return parse isbn generate-isbn10-rule
            ]
        ]

        print rejoin [ "--- " (length? isbn) " ---" ]

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

    /local generate-isbn13-rule: does [
        return [dash]
    ]

    /local generate-isbn10-rule: does [
        iteration: 1
        sum: 0

        return [
            10 [
                copy actual 
                digit (actual: to integer! actual)          
                (weight: 10 - iteration)
                (sum: sum + (actual * weight))
                (iteration: iteration + 1)
            ]

            if((sum % 11) == 0)
        ]
    ]
]
