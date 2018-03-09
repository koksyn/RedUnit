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
]

print "--- true ---"
probe valid/isbn "9788881837182" ;t
probe valid/isbn "9782266111560" ;t

print "--- false ---"
probe valid/isbn "9788328302341" ; f
probe valid/isbn "9788328314016" ; f
probe valid/isbn "9782123456803" ; f
probe valid/isbn "9782760510289" ; f

comment {
probe valid/isbn "978-83-283-0234-1"
probe valid/isbn "9788328302341"
probe valid/isbn "978-88-8183-718-2"
probe valid/isbn "978-2-266-11156-0"
probe valid/isbn "9788328314016"
probe valid/isbn "978-2-12-345680-3"
probe valid/isbn "978-88-8183-718-2"
probe valid/isbn "978-2-7605-1028-9"
probe valid/isbn "978-83-283-1401-6"

probe valid/isbn "888 18 3 7 1-88"
probe valid/isbn "2-7605-1028-X"
probe valid/isbn "2266111566"
probe valid/isbn "2123456802"
probe valid/isbn "8881837188"
probe valid/isbn "9971502100"
}

print "--- hm ---"

probe valid/isbn "99921-58-10-7" ; Qatar
probe valid/isbn "9971-5-0210-0" ; Singapore
probe valid/isbn "960-425-059-0" ; Greece
probe valid/isbn "80-902734-1-6" ; Czech Republic
probe valid/isbn "85-359-0277-5" ; Brazil

; English-speaking area
probe valid/isbn "1-84356-028-3"
probe valid/isbn "0-684-84328-5"
probe valid/isbn "0-8044-2957-X"
probe valid/isbn "0-85131-041-9"
probe valid/isbn "0-943396-04-2"
probe valid/isbn "0-9752298-0-X"