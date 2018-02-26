Red [
    Title: "Validator for VAT EU"
    Description: "The Value Added Tax (VAT) in European Union"
    Purpose: "Checking, that VAT number is valid for specific EU country"
    Author: "Mateusz Palichleb"
    File: %valid-vat-eu.red
]

comment {
    Script based on:
    - http://en.wikipedia.org/wiki/VAT_identification_number
    - http://ec.europa.eu/taxation_customs/vies/faq.html
}

valid-vat-eu: context [
    /local rules: make map![
        "PL" generate-rule-poland
        "HU" generate-rule-hungary
    ]

    check: func [
        "Check, that provided string is a valid VAT EU number"
        vat[string!]
    ] [
        if (empty? vat) or ((length? vat) < 3) [return false]

        ; country code validation
        country-code: uppercase copy/part vat 2
        if is-invalid-country-code country-code [return false]

        ; vat numbers
        numbers-amount: -1 * (length? vat) + 2
        vat-numbers: at tail vat numbers-amount

        ; generating rule
        rule: do (select rules country-code)

        return parse vat-numbers rule
    ]

    /local is-invalid-country-code: func [
        "Check, that country code is invalid or not known"
        code[string!]
    ] [
        country-codes: words-of rules
        found: find country-codes code

        return empty? found
    ]

    ;---------------- RULES GENERATORS -------------------
    /local numeric: charset "0123456789"

    /local generate-rule-hungary: does [
        return [8 [numeric]]
    ]

    ; based by weights algorithm
    ; https://pl.wikibooks.org/wiki/Kody_%C5%BAr%C3%B3d%C5%82owe/Implementacja_NIP
    /local generate-rule-poland: does [
        weights: [6 5 7 2 3 4 5 6 7]
        iteration: 1
        sum: 0

        put-input-to-actual-number: [
            copy actual-number
            numeric
            (actual-number: to integer! actual-number)
        ]

        return [
            9 [
                put-input-to-actual-number          
                (weight: pick weights iteration)
                (sum: sum + (actual-number * weight))
                (iteration: iteration + 1)
            ]

            put-input-to-actual-number
            if((sum % 11) == actual-number)
        ]
    ]
]

