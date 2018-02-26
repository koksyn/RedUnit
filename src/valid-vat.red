Red [
    Title: "Validator for VAT"
    Description: "The Value Added Tax (VAT) in European Union, Latin American countries, and other countries."
    Purpose: "Checking, that VAT number is valid for specific country"
    Author: "Mateusz Palichleb"
    File: %valid-vat.red
]

comment {
    Script based on:
    - http://en.wikipedia.org/wiki/VAT_identification_number
    - http://ec.europa.eu/taxation_customs/vies/faq.html
}

valid-vat: context [
    /local rules: make map![
        ; ------ European Union (EU) countries
        ;"AT" "U[A-Z\d]{8}" ;austria
        ;"BE" "0\d{9}" ;belgium
        ;"BG" "\d{9,10}" ;bulgaria
        "HR" generate-rule-croatia
        ;"CY" "\d{8}[A-Z]" ;cyprus
        ;"CZ" "\d{8,10}" ;czech republic
        ;"DK" "(\d{2} ?){3}\d{2}" ;denmark
        "EE" generate-rule-estonia
        "FI" generate-rule-finland
        ;"FR" "([A-Z]{2}|\d{2})\d{9}" ;france and monaco
        "DE" generate-rule-germany
        "EL" generate-rule-greece
        "GR" generate-rule-greece ;-- alternatively for Greece
        "HU" generate-rule-hungary
        ; IE: Seven digits and one last letter or six digits and two letters (second & last)
        ;"IE" "\d{7}[A-Z]|\d[A-Z]\d{5}[A-Z]" ireland
        "IT" generate-rule-italy
        "LV" generate-rule-latvia
        ;"LT" "(\d{9}|\d{12})" ;lithuania
        "LU" generate-rule-luxembourg
        "MT" generate-rule-malta
        ; NL: The 10th position following the prefix is always "B".
        ;"NL" "\d{9}B\d{2}" ; netherlands
        "PL" generate-rule-poland
        "PT" generate-rule-portugal
        ;"RO" "\d{2,10}" ;romania
        "SK" generate-rule-slovakia
        "SI" generate-rule-slovenia
        ; ES: The first and last characters may be alpha or numeric; but they may not both be numeric:
        ;"ES" "[A-Z]\d{7}[A-Z]|\d{8}[A-Z]|[A-Z]\d{8}" ;spain
        "SE" generate-rule-sweden
        ;"GB" "\d{9}|\d{12}|(GD|HA)\d{3}" ; United Kingdom and Isle of Man

        ; ------ Latin American countries
        "AR" generate-rule-argentina
        ;"BO" ;bolivia
        ;"BR" ;brazil
        ;"CL" "\d{8}-\d" ;chile
        "CO" generate-rule-colombia
        ;"CR" ;Costa Rica
        "EC" generate-rule-ecuador
        ;"SV" ;El Salvador
        ;"GT" "\d{7}-\d" ;Guatemala
        ;"HN" ;Honduras
        ;"MX" "\d{3} \d{6} \d{3}" ;Mexico
        ;"NI" ;Nicaragua
        ;"PA" ;Panama
        ;"PY" ;Paraguay
        ;"PE" ;Peru
        ;"DO" ;Dominican Republic
        ;"UY" ;Uruguay
        ;"VE" "[JGVE]-\d{8}-?\d" ;Venezuela

        ; ------ other countries
        ;"AL" "[KJ]\d{8}L" ;Albania
        "AU" generate-rule-australia
        "BY" generate-rule-belarus
        ;"CA" "[A-Z\d]{15}" ;Canada
        ;"IS" ;Iceland
        ;"IN" ;india
        ;"ID" ;indonesia
        ;"IL" ;israel
        ;"NZ" ;new zealand
        ;"NO" "\d{9}MVA" ;norway
        "PH" generate-rule-philippines
        ;"RU" "(\d{10}|\d{12})" ;Russia
        ;"SM" ;San Marino
        ;"RS" ;Serbia
        ;"CH" "(\d{6}|E\d{9}(TVA|MWST|IVA))" ;Switzerland
        "TR" generate-rule-turkey
        "UA" generate-rule-ukraine
        ;"UZ" ;Uzbekistan
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

    ; ------ European Union (EU) countries
    /local generate-rule-croatia: does [
        return [11 [numeric]]
    ]

    /local generate-rule-estonia: does [
        return [9 [numeric]]
    ]

    /local generate-rule-finland: does [
        return [8 [numeric]]
    ]

    /local generate-rule-germany: does [
        return [9 [numeric]]
    ]

    /local generate-rule-greece: does [
        return [9 [numeric]]
    ]

    /local generate-rule-hungary: does [
        return [8 [numeric]]
    ]

    /local generate-rule-italy: does [
        return [11 [numeric]]
    ]

    /local generate-rule-latvia: does [
        return [11 [numeric]]
    ]

    /local generate-rule-luxembourg: does [
        return [8 [numeric]]
    ]

    /local generate-rule-malta: does [
        return [8 [numeric]]
    ]

    ; based by weights MOD-11 algorithm
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

    /local generate-rule-portugal: does [
        return [9 [numeric]]
    ]

    /local generate-rule-slovakia: does [
        return [10 [numeric]]
    ]

    /local generate-rule-slovenia: does [
        return [8 [numeric]]
    ]

    /local generate-rule-sweden: does [
        return [12 [numeric]]
    ]

    ; ------ Latin American countries
    
    /local generate-rule-argentina: does [
        return [11 [numeric]]
    ]

    /local generate-rule-colombia: does [
        return [10 [numeric]]
    ]

    /local generate-rule-ecuador: does [
        return [13 [numeric]]
    ]

    ; ------ other countries

    /local generate-rule-australia: does [
        return [9 [numeric]]
    ]

    /local generate-rule-belarus: does [
        return [9 [numeric]]
    ]

    /local generate-rule-philippines: does [
        return [12 [numeric]]
    ]

    /local generate-rule-turkey: does [
        return [10 [numeric]]
    ]

    /local generate-rule-ukraine: does [
        return [12 [numeric]]
    ]
]

