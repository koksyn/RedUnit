# Tester 

File: [tester.red](../src/tester.red)

Usage: TODO

Version: 0.0.6

## Description

Tool for running tests of Red language scripts inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

"Tester" expects that you will give him a `object!`, which will contain test methods.
Each test method name should be started with `test-`. 

Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

### Ready features

- assertions
- special assertions for expected errors

### Features in development (roadmap)

- running tests from many files at once (v 0.0.7)
- data providers for testing a huge sets of data (v 0.1.0)

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