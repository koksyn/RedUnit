Red [
    Title: "SEDOL validator examples"
    Description: "Usage of SEDOL code validator"
    Author: "Mateusz Palichleb"
    File: %validator-sedol-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
;  Stock Exchange Daily Official List (SEDOL)
; ------------------------------------------------------
 
; valid
probe valid/sedol "7108899"
probe valid/sedol "B0YBKT7"
probe valid/sedol "2282765"
probe valid/sedol "B0WNLY7"

; invalid
probe valid/sedol "71088990" ; more than 7 characters
probe valid/sedol "B0WNLLN" ; character instead of digit at the end
probe valid/sedol "0123456" ; invalid check-digit

; Output:
; true
; true
; true
; true
; false
; false
; false