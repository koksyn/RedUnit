Red [
    Title: "POC examples"
    Description: "Usage of Prototype objects container (POC)"
    Author: "Mateusz Palichleb"
    File: %poc-examples.red
]

do %../src/poc.red

; ------------------------------------------------------
; Example 1: Adding and getting book by ISBN
; ------------------------------------------------------
 
ISBN: "999-8-76-543210-1"
book: object [title: "Red cookbook"]

poc/register ISBN book

result: poc/resolve ISBN
probe result/title

; Output:
; "Red cookbook"

; ------------------------------------------------------
; Example 2: Replacing book by the same ISBN
; ------------------------------------------------------
 
green-book: object [title: "Green book"]

poc/replace ISBN green-book

result: poc/resolve ISBN
probe result/title

; Output:
; "Green book"

; ------------------------------------------------------
; Example 3: Removing book and checking it does exist
; ------------------------------------------------------

probe poc/registered ISBN

; Output:
; true

poc/remove ISBN
probe poc/registered ISBN

; Output:
; false

; ------------------------------------------------------
; Handling errors
; ------------------------------------------------------
 
either error? result: try [poc/resolve "unknown-identifier"] [
    print ["Error message: " result/arg1]
] [
    print ["Everything fine! Your object: " result]
]

; Output:
; Error message:  Can not resolve an unregistered object
