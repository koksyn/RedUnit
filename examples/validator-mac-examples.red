Red [
    Title: "MAC validator examples"
    Description: "Usage of media access control (MAC) address validator"
    Author: "Mateusz Palichleb"
    File: %validator-mac-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
; MAC addresses
; ------------------------------------------------------
 
; valid
probe valid/mac "01ff.fa12.89ab"
probe valid/mac "00:09:3D:12:33:33"
probe valid/mac "01-23-45-67-89-ab"

; invalid
probe valid/mac "01.23:45-67:89:FF"
probe valid/mac "01-23AB-67-89-AB"
probe valid/mac "0123.456789ab"

; Output:
; true
; true
; true
; false
; false
; false