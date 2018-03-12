Red [
    Title: "SWIFT/BIC validator examples"
    Description: "Usage of Business Identifier Code (SWIFT or BIC) validator"
    Author: "Mateusz Palichleb"
    File: %validator-swift-bic-examples.red
]

do %../src/validator.red

; ------------------------------------------------------
; SWIFT/BIC codes
; ------------------------------------------------------
 
; valid
probe valid/swift-bic "UBSWCHZH80A" ; Switzerland
probe valid/swift-bic "GENODEF1JEV" ; Germany
probe valid/swift-bic "RZTIAT22263" ; Austria

; invalid
probe valid/swift-bic "MARK-DEF1"
probe valid/swift-bic "RBOS GGSX"

; Output:
; true
; true
; true
; false
; false