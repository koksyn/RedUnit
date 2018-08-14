Red [
    Package: "RedUnit"
    Title: "General module"
    Description: "Public interface, to be used globally."
    Author: "Mateusz Palichleb"
    File: %general.red
]

; you should use that public interface to test your code

context [
    run: func [
        path[file!]
    ] [
        require-path-exist path
        clear-context

        print "┌────────────────┐"
        print "│ RedUnit v0.0.3 │"
        print "└────────────────┘^/"

        case [
            dir? path [ run-dir path ]
            file? path [ run-file path ]
        ]

        print-execution-time
        print-summary

        print buffer/flush

        comment {
            CLI exit code for continuous integration 
            (0 - success, 1 - failure)
        }
        quit-when-errors
    ]

    set-test-filename-prefix: func [ 
        text[string!]
    ] [
        prefix: text
    ]

    set-test-filename-postfix: func [ 
        text[string!]
    ] [
        postfix: text
    ]
]