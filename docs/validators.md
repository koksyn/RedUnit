# Validators 

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [validator.red](../src/validator.red) | General validator. Contains all validators. |
| [validator-vat-tests.red](../tests/validator-vat-tests.red) | Tests for VAT validation |
| [validator-mac-tests.red](../tests/validator-mac-tests.red) | Tests for MAC address validation |
| [validator-vat-examples.red](../examples/validator-vat-examples.red) | Example usage of VAT validation as Red script |
| [validator-mac-examples.red](../examples/validator-mac-examples.red) | Example usage of MAC address validation as Red script |

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

## Usage of several validators

```red

do %src/validator.red

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

; ------------------------------------------------------
; Example 3: MAC addresses
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

```
