# Validators 

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [validator.red](../src/validator.red) | General validator. Contains all validators. |
| [validator-vat-tests.red](../tests/validator-vat-tests.red) | Tests for VAT |
| [validator-mac-tests.red](../tests/validator-mac-tests.red) | Tests for MAC |
| [validator-isbn-tests.red](../tests/validator-isbn-tests.red) | Tests for ISBN |
| [validator-credit-card-tests.red](../tests/validator-credit-card-tests.red) | Tests for Credit Card |
| [validator-sedol-tests.red](../tests/validator-sedol-tests.red) | Tests for SEDOL |
| [validator-swift-bic-tests.red](../tests/validator-swift-bic-tests.red) | Tests for SWIFT/BIC |
| [validator-vat-examples.red](../examples/validator-vat-examples.red) | Example usage of VAT |
| [validator-mac-examples.red](../examples/validator-mac-examples.red) | Example usage of MAC |
| [validator-isbn-examples.red](../examples/validator-isbn-examples.red) | Example usage of ISBN |
| [validator-credit-card-examples.red](../examples/validator-credit-card-examples.red) | Example usage of Credit Card |
| [validator-sedol-examples.red](../examples/validator-sedol-examples.red) | Example usage of SEDOL |
| [validator-swift-bic-examples.red](../examples/validator-swift-bic-examples.red) | Example usage of SWIFT/BIC |

## Description

Validators for various ISO codes, tax numbers, phones, goverment numbers, book industry and more.

All validators returns `logic!`. `True` on validation success, `false` otherwise.

## Methods

* **Check valid VAT** - is value a valid VAT number? (European Union, Latin American and other countries)

```red
valid/vat <value>
```

* **Check valid MAC address** - is value a valid MAC address?

```red
valid/mac <value>
```

* **Check valid ISBN number** - is value a valid ISBN (10 or 13 digits) number?

```red
valid/isbn <value>
```

* **Check valid Credit Card number** - is value a valid Credit Card number?

```red
valid/credit-card <value>
```

* **Check valid SEDOL code** - is value a valid Stock Exchange identifier ?

```red
valid/sedol <value>
```

* **Check valid SWIFT/BIC code** - is value a valid Business Identifier Code ?

```red
valid/swift-bic <value>
```

## Usage of several validators

```red

do %src/validator.red

; ------------------------------------------------------
; Valid VAT numbers for several countries
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
; Invalid VAT numbers
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

```
