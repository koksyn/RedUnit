Red [
    Title: "Tester"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %tester.red
    Version: "0.0.6"
]

tester-modules-builder: context [
    ; build and merge all of the modules into one merged object!
    build: does [
        /local modules: context []

        modules: add-object-from-file %tester/module-internal.red modules
        modules: add-object-from-file %tester/module-assertions.red modules
        modules: add-object-from-file %tester/module-general.red modules

        return modules
    ]

    /local add-object-from-file: func [
        "Add object from file to modules"
        filepath[file!]
        modules[object!]
    ] [
        /local loaded: do filepath

        unless object? loaded [
            print rejoin ["[Error] Loaded file '" (to string! filepath) "' does not contain an object!"]
            halt
        ]

        return make modules loaded
    ]
]

tester: tester-modules-builder/build