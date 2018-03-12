Red [
    Title: "Validator"
    Description: "Global validator as pack (wrapper) of various validators."
    Author: "Mateusz Palichleb"
    File: %validator.red
]

; you should use this file to validate

valid: context [
    /local validators: context [
        vat: do %validator/vat.red
        mac: do %validator/mac.red
        isbn: do %validator/isbn.red
        credit-card: do %validator/credit-card.red
        sedol: do %validator/sedol.red
        swift-bic: do %validator/swift-bic.red
    ]
    
    vat: func [
        "Is provided string a valid VAT number?"
        text[string!]
    ] [
        return validators/vat/validate text
    ]

    mac: func [
        "Is provided string a valid MAC address?"
        text[string!]
    ] [
        return validators/mac/validate text
    ]

    isbn: func [
        "Is provided string a valid ISBN?"
        text[string!]
    ] [
        return validators/isbn/validate text
    ]

    credit-card: func [
        "Is provided string a valid Credit Card number?"
        text[string!]
    ] [
        return validators/credit-card/validate text
    ]

    sedol: func [
        "Is provided string a valid Stock Exchange code?"
        text[string!]
    ] [
        return validators/sedol/validate text
    ]

    swift-bic: func [
        "Is provided string a valid SWIFT or BIC code?"
        text[string!]
    ] [
        return validators/swift-bic/validate text
    ]
]