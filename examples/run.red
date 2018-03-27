Red [
    Title: "POC Tests"
    Description: "Testing RedUnit 'run' method - which allow us to read whole directory of tests"
    Author: "Mateusz Palichleb"
    File: %run.red
]

do %../src/redunit.red

print "^/ Running... from child directory '/tests' ^/"
redunit/run %tests