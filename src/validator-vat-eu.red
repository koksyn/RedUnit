Red [
    Title: "Validator - VAT EU"
    Description: "The Value Added Tax (VAT) in European Union"
    Purpose: "Checking, that VAT number is valid for specific EU country"
    Author: "Mateusz Palichleb"
    File: %validator-vat-eu.red
]

comment {
    Script based on:
    - http://en.wikipedia.org/wiki/VAT_identification_number
    - http://ec.europa.eu/taxation_customs/vies/faq.html
}

validator-vat-eu: context [
    /local rules: make map![
        "PL" "\d{10}"
        "EN" "\d{6}"
    ]

    validate: func [
        "Check, that provided string is a valid VAT EU number"
        vat[string!]
    ] [
        if (empty? vat) or ((length? vat) < 3) [return false]

        country-code: copy/part vat 2
        if is-invalid-country-code country-code [return false]

        rule: select rules country-code
        probe rule

        return true
    ]

    is-invalid-country-code: func [
        "Check, that country code is invalid or not known"
        code[string!]
    ] [
        country-codes: words-of rules
        found: find country-codes code

        return empty? found
    ]
]

probe validator-vat-eu/validate ""
probe validator-vat-eu/validate "Px"
probe validator-vat-eu/validate "Px1"
probe validator-vat-eu/validate "PL1"
probe validator-vat-eu/validate "EN1"