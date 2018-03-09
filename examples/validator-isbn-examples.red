Red [
    Title: "ISBN validator examples"
    Description: "Usage of ISBN number validator"
    Author: "Mateusz Palichleb"
    File: %validator-isbn-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
; International Standard Book Number (ISBN)
; ------------------------------------------------------
 
; valid
probe valid/isbn "0-9752298-0-X" ; English-speaking area
probe valid/isbn "9971-5-0210-0" ; Singapore
probe valid/isbn "80-902734-1-6" ; Czech Republic
probe valid/isbn "85-359-0277-5" ; Brazil

; invalid
probe valid/isbn "978-3-16-148410-X" ; Forbidden character for ISBN-13
probe valid/isbn "978-88-8183-7-1-8-8" ; Invalid checksum digit

; Output:
; true
; true
; true
; true
; false
; false