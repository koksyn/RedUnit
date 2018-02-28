# Validators 

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [valid-vat.red](../src/valid-vat.red) | VAT validator |
| [valid-vat-tests.red](../tests/valid-vat-tests.red) | Tests for VAT validator |

## Description

Validators for various ISO codes, tax numbers, phones, goverment numbers, book industry and more.

All validators returns `logic!`. `True` on validation success, `false` otherwise.

## Methods

* **Check valid VAT** - is value a valid VAT (Value Added Tax) number? (European Union, Latin American and other countries)

```red
valid-vat/check <value>
```

## Usage

```red

do %src/valid-vat.red

; ------------------------------------------------------
; Example 1: Valid VAT numbers for several countries
; ------------------------------------------------------

; "Poland"
probe valid-vat/check "PL8567346215"

; "Switzerland"
probe valid-vat/check "CHE162856788TVA"

; "Netherlands"
probe valid-vat/check "NL004495445B01"

; "Chile"
probe valid-vat/check "CL21472149-5"

; "Australia"
probe valid-vat/check "ALJ52263223X"

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
probe valid-vat/check "PL1234567890"

; "Switzerland"
probe valid-vat/check "CHE123456788"

; "Netherlands"
probe valid-vat/check "NL123456789X90"

; "Chile"
probe valid-vat/check "CL214721495X"

; "Unknown values and countries"
probe valid-vat/check "xy987654321"
probe valid-vat/check "123456789"

; Output:
; false
; false
; false
; false
; false
; false

```