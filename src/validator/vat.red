Red [
    Package: "Validator"
    Title: "VAT validator"
    Description: "The Value Added Tax (VAT) in European Union, Latin American countries, and other countries."
    Purpose: "Checking, that VAT number is valid for specific country"
    Author: "Mateusz Palichleb"
    File: %vat.red
]

comment {
    Internal file as part of Validator tool

    Script based on:
    - http://en.wikipedia.org/wiki/VAT_identification_number
    - http://ec.europa.eu/taxation_customs/vies/faq.html
}

context [
    validate: func [
        "Check, that provided string is a valid VAT number"
        vat[string!]
    ] [
        if (empty? vat) or ((length? vat) < 3) [return false]

        ; country code validation
        country-code: copy/part vat 2
        if is-invalid-country-code country-code [return false]

        ; vat tail without country code
        numbers-amount: -1 * (length? vat) + 2
        vat-tail: at tail vat numbers-amount

        remove-whitespaces vat-tail

        ; generate rule
        rule: do (select rules country-code)

        ; execute rule
        return parse vat-tail rule
    ]

    /local rules: make map![
        ; ------ European Union (EU) countries
        "AT" generate-rule-austria
        "BE" generate-rule-belgium
        "BG" generate-rule-bulgaria
        "HR" generate-rule-croatia
        "CY" generate-rule-cyprus
        "CZ" generate-rule-czech-republic
        "DK" generate-rule-denmark
        "EE" generate-rule-estonia
        "FI" generate-rule-finland
        "FR" generate-rule-france-monaco
        "DE" generate-rule-germany
        "EL" generate-rule-greece
        "GR" generate-rule-greece ;-- alternatively for Greece
        "HU" generate-rule-hungary
        "IE" generate-rule-ireland
        "IT" generate-rule-italy
        "LV" generate-rule-latvia
        "LT" generate-rule-lithuania
        "LU" generate-rule-luxembourg
        "MT" generate-rule-malta
        "NL" generate-rule-netherlands
        "PL" generate-rule-poland
        "PT" generate-rule-portugal
        "RO" generate-rule-romania
        "SK" generate-rule-slovakia
        "SI" generate-rule-slovenia
        "ES" generate-rule-spain
        "SE" generate-rule-sweden
        "GB" generate-rule-united-kingdom-isle-of-man

        ; ------ Latin American countries
        "AR" generate-rule-argentina
        "BO" generate-rule-bolivia
        "BR" generate-rule-brazil
        "CL" generate-rule-chile
        "CO" generate-rule-colombia
        "CR" generate-rule-costa-rica
        "EC" generate-rule-ecuador
        "GT" generate-rule-guatemala
        "MX" generate-rule-mexico
        "NI" generate-rule-nicaragua
        "PY" generate-rule-paraguay
        "PE" generate-rule-peru
        "DO" generate-rule-dominican-republic
        "UY" generate-rule-uruguay
        "VE" generate-rule-venezuela

        ; ------ Other countries
        "AL" generate-rule-albania
        "AU" generate-rule-australia
        "BY" generate-rule-belarus
        "CA" generate-rule-canada
        "IS" generate-rule-iceland
        "IN" generate-rule-india
        "ID" generate-rule-indonesia
        "IL" generate-rule-israel
        "NZ" generate-rule-new-zealand
        "NO" generate-rule-norway
        "PH" generate-rule-philippines
        "RU" generate-rule-russia
        "SM" generate-rule-san-marino
        "RS" generate-rule-serbia
        "ZA" generate-rule-south-africa
        "CH" generate-rule-switzerland
        "TR" generate-rule-turkey
        "UA" generate-rule-ukraine
        "UZ" generate-rule-uzbekistan
    ]

    /local is-invalid-country-code: func [
        "Check, that country code is invalid or not known"
        code[string!]
    ] [
        country-codes: words-of rules
        found: find/case country-codes code

        return empty? found
    ]

    /local remove-whitespaces: func [
        "Removes all whitespaces from provided subject"
        subject[string!]
    ] [
        parse subject [any [to whitespace change whitespace ""]]
    ]

    ;---------------- RULES GENERATORS -------------------
    /local whitespace: charset reduce [space tab cr lf]
    /local not-whitespace: charset reduce ['not space tab cr lf]
    /local letter: charset [#"A" - #"Z"]
    /local digit: charset "0123456789"
    /local alphanum: union letter digit
    /local dash: charset "‐-"

    ; ------ European Union (EU) countries

    /local generate-rule-austria: does [
        return [
            "U" 8 [alphanum]
        ]
    ]

    /local generate-rule-belgium: does [
        return [
            [
                ["0" | "1"] 
                9 [digit]
            ]
            ; old formats
            | [9 [digit]]
            | [3 [digit] dot 3[digit] dot 3 [digit]]
        ]
    ]

    /local generate-rule-bulgaria: does [
        return [
            [10 [digit]]
            | [9 [digit]]
        ]
    ]

    /local generate-rule-croatia: does [
        return [11 [digit]]
    ]

    /local generate-rule-cyprus: does [
        return [
            9 [alphanum]
        ]
    ]

    /local generate-rule-czech-republic: does [
        return [
            [10 [digit]]
            | [9 [digit]]
            | [8 [digit]]
        ]
    ]

    /local generate-rule-denmark: does [
        return [8 [digit]]
    ]

    /local generate-rule-estonia: does [
        return [9 [digit]]
    ]

    /local generate-rule-finland: does [
        return [8 [digit]]
    ]

    /local generate-rule-france-monaco: does [
        return [
            2 [alphanum] 9 [digit]
        ]
    ]

    /local generate-rule-germany: does [
        return [9 [digit]]
    ]

    /local generate-rule-greece: does [
        return [9 [digit]]
    ]

    /local generate-rule-hungary: does [
        return [8 [digit]]
    ]

    /local generate-rule-ireland: func [
        "(7 digits + letter) OR (digit + letter + 5 digits + letter)"
    ] [
        return [
            [7 [digit] 2 [letter]]
            | [7 [digit] letter]
            | [
                digit 
                [letter | "+" | "*"] 
                5 [digit] 
                letter
            ]
        ]
    ]

    /local generate-rule-italy: does [
        return [11 [digit]]
    ]

    /local generate-rule-latvia: does [
        return [11 [digit]]
    ]

    /local generate-rule-lithuania: does [
        return [
            [12 [digit]]
            | [9 [digit]]
        ]
    ]

    /local generate-rule-luxembourg: does [
        return [8 [digit]]
    ]

    /local generate-rule-malta: does [
        return [8 [digit]]
    ]

    /local generate-rule-netherlands: does [
        return [
            9 [digit] "B" 2 [digit]
        ]
    ]

    ; based by weights MOD-11 algorithm
    ; https://pl.wikibooks.org/wiki/Kody_%C5%BAr%C3%B3d%C5%82owe/Implementacja_NIP
    /local generate-rule-poland: does [
        weights: [6 5 7 2 3 4 5 6 7]
        iteration: 1
        sum: 0

        put-input-to-actual-number: [
            copy actual-number
            digit
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
        return [9 [digit]]
    ]

    /local generate-rule-romania: does [
        return [
            [10 [digit]]
            | [9 [digit]]
            | [8 [digit]]
            | [7 [digit]]
            | [6 [digit]]
            | [5 [digit]]
            | [4 [digit]]
            | [3 [digit]]
            | [2 [digit]]
        ]
    ]

    /local generate-rule-slovakia: does [
        return [10 [digit]]
    ]

    /local generate-rule-slovenia: does [
        return [8 [digit]]
    ]

    /local generate-rule-spain: does [
        return [
            [letter 7 [digit] letter]
            | [8 [digit] letter]
            | [letter 8 [digit]]
        ]
    ]

    /local generate-rule-sweden: does [
        return [12 [digit]]
    ]

    /local generate-rule-united-kingdom-isle-of-man: does [
        return [
            [12 [digit]]
            | [9 [digit]]
            | [
              [["G" "D"] | ["H" "A"]] 3 [digit]
            ]
        ]
    ]

    ; ------ Latin American countries
    
    /local generate-rule-argentina: does [
        return [11 [digit]]
    ]

    /local generate-rule-bolivia: does [
        return [7 [digit]]
    ]

    ; CNPJ format '11.111.111/0001-55'
    ; CPF format '123.456.789-00'
    /local generate-rule-brazil: does [
        return [
            ; same digits
            [14 [digit]]
            | [11 [digit]]
            ; CNPJ
            | [
                2 [digit] dot 3 [digit] dot 3 [digit] 
                slash 
                4 [digit] dash 2 [digit]
            ]
            ; CPF
            | [
                3 [digit] dot 3 [digit] dot 3 [digit] dash 2 [digit]
            ]
        ]
    ]

    /local generate-rule-chile: does [
        return [
            8 [digit] dash digit
        ]
    ]

    /local generate-rule-colombia: does [
        return [10 [digit]]
    ]

    /local generate-rule-costa-rica: does [
        return [
            [12 [digit]]
            ; DIMEX
            | [11 [digit]]
            ; NITE
            | [10 [digit]]
            ; person's national identification number
            | [9 [digit]]
        ]
    ]

    /local generate-rule-ecuador: does [
        return [13 [digit]]
    ]

    /local generate-rule-guatemala: does [
        return [
            7 [digit] dash digit
        ]
    ]

    /local generate-rule-mexico: does [
        return [
            [3 [digit] 6 [digit] 3 [digit]]
            | [4 [not-whitespace] 6 [digit] 3 [not-whitespace]]
            | [3 [not-whitespace] 6 [digit] 3 [not-whitespace]]
        ]
    ]

    /local generate-rule-nicaragua: does [
        return [
            3 [digit] dash 6 [digit] dash 4 [digit] letter
        ]
    ]

    /local generate-rule-paraguay: does [
        return [
            6 [digit] dash digit
        ]
    ]

    /local generate-rule-peru: does [
        return [11 [digit]]
    ]

    /local generate-rule-dominican-republic: does [
        return [
            [11 [digit]] | [9 [digit]]
        ]
    ]

    /local generate-rule-uruguay: does [
        return [
            digit dot 3 [digit] dot 3 [digit] dash digit
        ]
    ]

    /local generate-rule-venezuela: does [
        /local JGVE: charset "JGVE"

        return [
            JGVE 
            [
                [9 [digit]]
                | [8 [digit] "-" digit]
                | [dash 9 [digit]]
                | [dash 8 [digit] dash digit]
            ]
        ]
    ]

    ; ------ other countries

    /local generate-rule-albania: does [
        return [
            ["K" | "J"] 8 [digit] letter
        ]
    ]

    /local generate-rule-australia: does [
        return [9 [digit]]
    ]

    /local generate-rule-belarus: does [
        return [9 [digit]]
    ]

    /local generate-rule-canada: does [
        return [
            15 [alphanum]
        ]
    ]

    /local generate-rule-iceland: does [
        return [
            [7 [digit]]
            | [6 [digit]]
            | [5 [digit]]
        ]
    ]

    /local generate-rule-india: does [
        return [
            11 [digit] ["V" | "C"]
        ]
    ]

    /local generate-rule-indonesia: does [
        return [
            [15 [digit]]
            | [
                2 [digit] dot 3 [digit] dot 3 [digit] dot digit
                dash 3 [digit] dot 3 [digit]
            ]
        ]
    ]

    /local generate-rule-israel: does [
        return [9 [digit]]
    ]

    /local generate-rule-new-zealand: does [
        return [13 [digit]]
    ]

    /local generate-rule-norway: does [
        return [9 [digit] "M" "V" "A"]
    ]

    /local generate-rule-philippines: does [
        return [12 [digit]]
    ]

    /local generate-rule-russia: does [
        return [
            [12 [digit]]
            | [10 [digit]]
        ]
    ]

    /local generate-rule-san-marino: does [
        return [5 [digit]]
    ]

    /local generate-rule-serbia: does [
        return [9 [digit]]
    ]

    ; https://www.etl-tools.com/regular-expressions/is-south-african-vat-number.html
    /local generate-rule-south-africa: does [
        return [
            ["3" | "4"] 
            [
                [10 [digit]]
                | [9 [digit]]
            ]
        ]
    ]

    /local generate-rule-switzerland: does [
        return [
            [6 [digit]]
            | [
                "E" 
                9 [digit] 
                [
                    ["T" "V" "A"] 
                    | ["M" "W" "S" "T"] 
                    | ["I" "V" "A"]
                ]
            ]
        ]
    ]

    /local generate-rule-turkey: does [
        return [10 [digit]]
    ]

    /local generate-rule-ukraine: does [
        return [
            [12 [digit]]
            | [10 [digit]]
        ]
    ]

    /local generate-rule-uzbekistan: does [
        return [
            ["2" 8 [digit]]
            | [
                ["4" | "5" | "6" | "7"] 
                8 [digit]
            ]
        ]
    ]
]