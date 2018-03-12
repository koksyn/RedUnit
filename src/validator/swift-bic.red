Red [
    Package: "Validator"
    Title: "SWIFT/BIC code validator"
    Description: "Business Identifier (BIC or SWIFT) codes for both financial or not-financial institutions"
    Author: "Mateusz Palichleb"
    File: %swift-bic.red
]

comment {
    Internal file as part of Validator tool
    Script based on: 
    - https://en.wikipedia.org/wiki/ISO_9362
    - http://networking.mydesigntool.com/viewtopic.php?tid=301&id=31
}

context [
    /local digit: charset "0123456789"
    /local lower: charset [#"a" - #"z"]
    /local upper: charset [#"A" - #"Z"]
    /local letters: union lower upper
    /local alpha: union letters digit

    validate: func [
        "Is provided string a valid SWIFT or BIC code?"
        code[string!]
    ] [
        if (empty? code) [return false]

        return parse code [
            [6 [letters] 2 [alpha] 3[alpha]]
            | [6 [letters] 2 [alpha]]
        ]
    ]
]
