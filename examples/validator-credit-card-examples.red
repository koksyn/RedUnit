Red [
    Title: "Credit Card number validator examples"
    Description: "Usage of Credit Card number validator"
    Author: "Mateusz Palichleb"
    File: %validator-credit-card-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
; Credit Card numbers
; ------------------------------------------------------
 
; valid
probe valid/credit-card "2223 0031 2200 3222" ; Mastercard
probe valid/credit-card "4000 0566 5566 5556" ; Visa
probe valid/credit-card "4111 1111 1111 1111" ; Visa
probe valid/credit-card "3714 496353 98431" ; American Express
probe valid/credit-card "3714 496353 98431" ; UnionPay

; invalid
probe valid/credit-card "3530 1113 3330 000"
probe valid/credit-card "4111111111111112" ; invalid check-digit for VISA

; Output:
; true
; true
; true
; true
; true
; false
; false