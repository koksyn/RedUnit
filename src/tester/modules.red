Red [
    Package: "Tester"
    Title: "Modules builder"
    Description: "Pack of modules all-in-one for Tester tool"
    Purpose: "Join all modules into one object."
    Author: "Mateusz Palichleb"
    File: %modules.red
]

;-- Internal methods and fields

do %module-internal.red
tester-modules: tester-internal

;-- Assertions

do %module-assertions.red
tester-modules: make tester-modules tester-assertions