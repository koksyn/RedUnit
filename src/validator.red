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
    ]
    
    vat: func [
        "Check, that provided string is a valid VAT number"
        text[string!]
    ] [
        return validators/vat/validate text
    ]
]