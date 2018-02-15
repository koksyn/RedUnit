Red [
    Title: "Run all tests"
    Description: "Will detect and execute all "****-tests.red" tests under /tests directory"
    Author: "Mateusz Palichleb"
    File: %run-all-tests.red
]

files: read %tests/

foreach file files [	
    if find file "-tests.red" [
        test-file-path: rejoin ["tests/" file]
        print rejoin [ "^/>> " test-file-path "^/"]

        test-file: to file! test-file-path
        do test-file
    ]
]
