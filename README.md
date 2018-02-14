# Red particles

Pack of varied **tools** for **Red** language.

### Tools

- **POC** - Prototype objects container 
- **Tester** - Testing tool

### Tests for tools

To run tests simply execute script `run-all-tests.red` from project main directory through **Red** binary.
This script will detect and execute all test files like `***-tests.red` under `/tests` directory.

```bash
./red -s run-all-tests.red
```

## Prototype objects container 

`src/poc.red`

#### Purpose

Ability to store objects safely in a *key-value* map, with access control and type checking. Currently `map!` can store anything, so *POC* will guarantee, that only objects will be stored. Fetching chosen element will return a clone of object prototype. 

## "Tester" testing tool 

`src/tester.red`

#### Purpose

Tool for running tests of Red language scripts inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

#### Description

"Tester" expects that you will give him a `object!`, which will contain test methods. Each test method name should be started with `test-`. Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

#### Example:

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
Version 0.0.2

[test] test-registered-item [Success]

Execution time: 0.004187 sec
---------------------------
```
