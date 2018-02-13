Red [
    Title: "Run all tests"
    Description: "Will detect and execute all .red tests under /tests directory"
    Author: "Mateusz Palichleb"
    Supports: "Linux,Mac"
    File: %run-all-tests.red
]

;-- definitions
list: ""
command: "ls tests"

;-- executing command
call/output command list

; convert output to series string
parse list [some [to "^/" change "^/" " "]]
list: trim list
parse list [some [to " " change " " "^" ^""]]
list: append append "[^"" list "^"]"

; convert string to series
series: do list

; execute each file like "****-tests.red" from "/tests" directory
foreach element series [	
    if find element "-tests.red" [
        test-file-path: rejoin ["tests/" element]
        test-file: to file! test-file-path
	do test-file
    ]
]
