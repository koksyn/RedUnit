Red [
    Description: "Testing RedUnit 'run' method - which allow us to read whole directory of tests"
    Author: "Mateusz Palichleb"
    File: %run-directory.red
]

do %../src/redunit.red

comment {^/ Running... from child directory '/examples/tests' ^/}
redunit/run %tests/