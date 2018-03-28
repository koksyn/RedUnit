Red [
    Description: "Testing RedUnit 'run-single' method"
    Author: "Mateusz Palichleb"
    File: %run-single-files.red
]

do %../src/redunit.red

redunit/run %tests/poc-tests.red

print "^/ Running other single file...^/"

redunit/run %tests/simple-tests.red