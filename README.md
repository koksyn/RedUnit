# Red particles

Pack of varied **tools** for **Red** language.

## Running tests

To run tests simply execute script `run-all-tests.red` from project main directory through **Red** binary.
This script will detect and execute all test files like `***-tests.red` under `/tests` directory.

```bash
./red -s run-all-tests.red
```

## Tools

### Prototype objects container 

**File** `src/poc.red`

**Purpose**

Ability to store objects safely in a *key-value* map, with access control and type checking. Currently `map!` can store anything, so *POC* will guarantee, that only objects will be stored. Fetching chosen element will return a clone of object prototype. 

### "Tester" testing tool 

**File** `src/tester.red`

**Purpose**

Tool for running tests of Red language scripts inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

**Description**

"Tester" expects that you will give him a `object!`, which will contain test methods. Each test method name should be started with "test-". Also `startup` method is executed before each test separately - optionally (only if `object!` consist method with name `startup`).

Example:

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
        tester/assert-true result none
    ]
]

tester/run tests
```

Execution & output in console:

```
./red -s test.red 
--------- Tester ----------
Version 0.0.1

[test] test-registered-item [Success]

Execution time: 0.004187 sec
---------------------------
```
