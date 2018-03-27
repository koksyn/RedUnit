Red [
    Title: "POC Tests"
    Description: "Testing RedUnit 'run-single' method"
    Author: "Mateusz Palichleb"
    File: %run-single.red
]

do %../src/redunit.red

print "^/ Running... from child directory ^/"
redunit/run-single %tests/poc-tests.red

print "^/ Running once again... from actual directory ^/"
redunit/run-single %poc-tests.red