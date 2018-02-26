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
        "HR" "\d{11}" ;croatia
        ;"CY" "\d{8}[A-Z]" ;cyprus
        ;"CZ" "\d{8,10}" ;czech republic
        ;"DK" "(\d{2} ?){3}\d{2}" ;denmark
        "EE" "\d{9}" ;estonia
        "FI" "\d{8}" ;finland
        ;"FR" "([A-Z]{2}|\d{2})\d{9}" ;france and monaco
        "DE" "\d{9}" ; germany
        "EL" "\d{9}" ; greece
        "GR" "\d{9}" ; greece second
        "HU" generate-rule-hungary
        ; IE: Seven digits and one last letter or six digits and two letters (second & last)
        ;"IE" "\d{7}[A-Z]|\d[A-Z]\d{5}[A-Z]" ireland
        "IT" "\d{11}" ;italy
        "LV" "\d{11}" ;latvia
        ;"LT" "(\d{9}|\d{12})" ;lithuania
        "LU" "\d{8}" ; luxembourg
        "MT" "\d{8}" ;malta
        ; NL: The 10th position following the prefix is always "B".
        ;"NL" "\d{9}B\d{2}" ; netherlands
        "PL" generate-rule-poland
        "PT" "\d{9}" ; portugal
        ;"RO" "\d{2,10}" ;romania
        "SK" "\d{10}" ;slovakia
        "SI" "\d{8}" ;slovenia
        ; ES: The first and last characters may be alpha or numeric; but they may not both be numeric:
        ;"ES" "[A-Z]\d{7}[A-Z]|\d{8}[A-Z]|[A-Z]\d{8}" ;spain
        "SE" "\d{12}" ;sweden
        ;"GB" "\d{9}|\d{12}|(GD|HA)\d{3}" ; United Kingdom and Isle of Man

        ; ------ Latin American countries
        "AR" "\d{11}" ; argentina
        ;"BO" ;bolivia
        ;"BR" ;brazil
        ;"CL" "\d{8}-\d" ;chile
        "CO" "\d{10}" ;colombia
        ;"CR" ;Costa Rica
        "EC" "\d{13}" ;Ecuador
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
        "AU" "\d{9}" ;australia
        "BY" "\d{9}" ;belarus
        ;"CA" "[A-Z\d]{15}" ;Canada
        ;"IS" ;Iceland
        ;"IN" ;india
        ;"ID" ;indonesia
        ;"IL" ;israel
        ;"NZ" ;new zealand
        ;"NO" "\d{9}MVA" ;norway
        "PH" "\d{12}" ;Philippines
        ;"RU" "(\d{10}|\d{12})" ;Russia
        ;"SM" ;San Marino
        ;"RS" ;Serbia
        ;"CH" "(\d{6}|E\d{9}(TVA|MWST|IVA))" ;Switzerland
        "TR" "\d{10}" ;Turkey
        "UA" "\d{12}" ;Ukraine
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

