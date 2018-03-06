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
        mac: do %mac.red
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
]