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

probe valid/vat "PL8567346215" ; Poland
probe valid/vat "CHE162856788TVA" ; Switzerland
probe valid/vat "NL004495445B01" ; Netherlands
probe valid/vat "CL21472149-5" ; Chile
probe valid/vat "ALJ52263223X" ; Australia

; Output:
; true
; true
; true
; true
; true

; ------------------------------------------------------
; Example 2: Invalid VAT numbers
; ------------------------------------------------------
 
probe valid/vat "PL1234567890" ; Poland
probe valid/vat "CHE123456788" ; Switzerland
probe valid/vat "NL123456789X90" ; Netherlands
probe valid/vat "CL214721495X" ; Chile

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