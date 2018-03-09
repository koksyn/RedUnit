# Validators 

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [validator.red](../src/validator.red) | General validator. Contains all validators. |
| [validator-vat-tests.red](../tests/validator-vat-tests.red) | Tests for VAT |
| [validator-mac-tests.red](../tests/validator-mac-tests.red) | Tests for MAC |
| [validator-isbn-tests.red](../tests/validator-isbn-tests.red) | Tests for ISBN |
| [validator-vat-examples.red](../examples/validator-vat-examples.red) | Example usage of VAT |
| [validator-mac-examples.red](../examples/validator-mac-examples.red) | Example usage of MAC |
| [validator-isbn-examples.red](../examples/validator-isbn-examples.red) | Example usage of ISBN |

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

## Usage of several validators

```red

do %src/validator.red

; ------------------------------------------------------
; Valid VAT numbers for several countries
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
; Invalid VAT numbers
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

```
