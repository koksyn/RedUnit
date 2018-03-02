Red [
    Package: "Tester"
    Title: "Modules builder"
    Description: "Pack of modules all-in-one for Tester tool"
    Purpose: "Join all modules into one object."
    Author: "Mateusz Palichleb"
    File: %modules-builder.red
]

return context [
    ; build and merge all of the modules into one merged object!
    build: does [
        /local modules: context []

        modules: add-object-from-file %module-internal.red modules
        modules: add-object-from-file %module-assertions.red modules
        modules: add-object-from-file %module-general.red modules

        return modules
    ]

    /local add-object-from-file: func [
        "Add object from file to modules"
        filepath[file!]
        modules[object!]
    ] [
        /local loaded: do filepath

        if not object? loaded [
            print rejoin ["[Error] Loaded file '" (to string! filepath) "' does not contain an object!"]
            halt
        ]

        return make modules loaded
    ]
]