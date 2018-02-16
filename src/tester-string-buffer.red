Red [
    Title: "[Tester] String Buffer"
    Description: "Part of Tester tool, which is a buffer for string! values."
    Purpose: "Reducing tests execution time. Using string buffer instead of console output will speed up execution."
    Author: "Mateusz Palichleb"
    File: %tester-string-buffer.red
]

tester-string-buffer: context [
    /local buffer: ""

    put: func [
        "Will put value to the buffer tail"
        value[string!]
    ] [
        buffer: append buffer value
    ]

    put-line: func [
        "Will put value with EOL to the buffer tail"
        value[string!]
    ] [
        buffer: rejoin [buffer value "^/"]
    ]

    ;-- "Clear the buffer by outputing everything"
    flush: does [
        /local output: buffer
        clear

        output
    ]

    ;-- "Clear the buffer"
    clear: does [buffer: ""]
]