Red [
    Package: "Validator"
    Title: "48-bit MAC address validator"
    Description: "The media access control (MAC) address is a unique identifier assigned to network interface controllers"
    Author: "Mateusz Palichleb"
    File: %mac.red
]

comment {
    Internal file as part of Validator tool
    Script based on: http://en.wikipedia.org/wiki/MAC_address#Notational_conventions
}

context [
    /local whitespace: charset reduce [space tab cr lf]
    /local digit: charset "0123456789"
    /local lower: charset [#"a" - #"f"]
    /local upper: charset [#"A" - #"F"]
    /local lower-hex: union lower digit
    /local upper-hex: union upper digit
    /local dash: charset "-‐"
    /local colon: charset ":"

    validate: func [
        "Is provided string a valid MAC address?"
        mac[string!]
    ] [
        if (empty? mac) or ((length? mac) < 14) [return false]

        remove-whitespaces mac

        return parse mac generate-mac-rule
    ]

    /local remove-whitespaces: func [
        "Removes all whitespaces from provided subject"
        subject[string!]
    ] [
        parse subject [any [to whitespace change whitespace ""]]
    ]

    /local generate-mac-rule: func [
        {Could be separated by colons(:) or dashes(-) or dots(.). 
        Mixed separators and lower/uppercases are forbidden.}
    ] [
        return [
            [
                5 [2 [lower-hex] dash] 
                2 [lower-hex]
            ]
            | [
                5 [2 [upper-hex] dash] 
                2 [upper-hex]
            ]
            | [
                5 [2 [lower-hex] colon] 
                2 [lower-hex]
            ]
            | [
                5 [2 [upper-hex] colon] 
                2 [upper-hex]
            ]
            | [
                2 [4 [lower-hex] dot] 
                4 [lower-hex]
            ]
            | [
                2 [4 [upper-hex] dot] 
                4 [upper-hex]
            ]
        ]
    ]
]
