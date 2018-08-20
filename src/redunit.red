Red [
    Title: "RedUnit"
    Description: "Tool for running tests of Red scripts like in xUnit, nUnit and other similar libs."
    Purpose: "Be able to test Red language scripts"
    Author: "Mateusz Palichleb"
    File: %redunit.red
    Version: "0.0.3"
]

redunit-modules-builder: context [
    ; build and merge all of the modules into one merged object!
    build: does [
        /local modules: context []

        modules: add-object-from-file %modules/internal.red modules
        modules: add-object-from-file %modules/assertions.red modules
        modules: add-object-from-file %modules/general.red modules

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

redunit: redunit-modules-builder/build