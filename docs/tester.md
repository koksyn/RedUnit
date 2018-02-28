# Tester 

File: [tester.red](../src/tester.red)

Usage: TODO

Version: 0.0.6

## Description

Tool for running tests of Red language scripts inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

"Tester" expects that you will give him a `object!`, which will contain test methods.
Each test method name should be started with `test-`. 

Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

## Features (Roadmap)
- [x] [v 1.1.1] special assertion for expected errors (v 0.0.2)
- [x] logic assertions for tests (v 0.0.3)
- [x] reducing tests execution time, using string buffer instead of console output (v 0.0.4)
- [x] splitting script into modules (v 0.0.5)
- [ ] adding original error trace when assertion failed (v 0.0.7)
- [ ] running tests from many files at once (v 0.0.8)
- [ ] redesigning the console output for statuses of tests (v 0.0.9)
- [ ] data providers for testing a huge sets of data (v 0.1)
- [ ] extending expected-error assertion by defining a type of error we expect (v 0.1.1)
- [ ] simple mocks for objects and methods (v 0.1.2)
- [ ] 'method' assertions for mocks - checking/expecting the mock method was executed (v 0.1.3)
- [ ] 'argument' assertions for mock methods - checking/expecting an arguments of mock methods (v 0.1.4)
- [ ] 'return' assertions for mock methods - forcing/expecting that mock method will return specific value (v 0.1.5)
- [ ] refactoring, goal: increase execution time and readability (v 0.1.6)
- [ ] redesigning an API of all public methods - goal: cohesion (v 0.2)
- [ ] module to detect code coverage of tested objects (v 0.3)

## Methods

TODO

## Usage

```red
Red [
    File: %test.red
]

do %src/tester.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %src/poc.red
    ]

    test-registered-item: func [
        "Testing that item was successfully registered"
    ] [
        book: object [title: "Red cookbook"]
        poc/register "my-book" book
        
        result: poc/registered "my-book"
        tester/assert-true result
    ]
]

tester/run tests
```

Console output:

```bash
./red -s test.red 
--------- Tester ----------
Version 0.0.6

[test] test-registered-item [Success]

Execution time: 0.004187 sec
---------------------------
```