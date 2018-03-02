Red [
    Title: "VAT validator examples"
    Description: "Usage of Value Added Tax (VAT) validator"
    Author: "Mateusz Palichleb"
    File: %validator-vat-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
; Example 1: Valid VAT numbers for several countries
; ------------------------------------------------------

; "Poland"
probe valid/vat "PL8567346215"

; "Switzerland"
probe valid/vat "CHE162856788TVA"

; "Netherlands"
probe valid/vat "NL004495445B01"

; "Chile"
probe valid/vat "CL21472149-5"

; "Australia"
probe valid/vat "ALJ52263223X"

; Output:
; true
; true
; true
; true
; true

; ------------------------------------------------------
; Example 2: Invalid VAT numbers
; ------------------------------------------------------
 
; "Poland"
probe valid/vat "PL1234567890"

; "Switzerland"
probe valid/vat "CHE123456788"

; "Netherlands"
probe valid/vat "NL123456789X90"

; "Chile"
probe valid/vat "CL214721495X"

; "Unknown values and countries"
probe valid/vat "xy987654321"
probe valid/vat "123456789"

; Output:
; false
; false
; false
; false
; false
; false