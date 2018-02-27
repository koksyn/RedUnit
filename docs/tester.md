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
Version 0.0.5

[test] test-registered-item [Success]

Execution time: 0.004187 sec
---------------------------
```





# inne

 
#### **Tester** - Testing tool

File: [src/tester.red](`src/tester.red`)

Documentation: `docs/tester.md`

Tool for running tests of Red language scripts inspired by PhpUnit, xUnit, nUnit and other similar libraries. Offers:

- assertions
- special assertions for expected errors
- data providers for testing a huge sets of data
- running tests from many files at once

#### **Validators** - Check provided code is valid

Files: `src/valid-***.red`

Documentation: `docs/validators.md`

Tool for checking codes:

- VAT numbers from EU, Latin America and other countires - `src/valid-vat.red`
- Phone numbers for various countries - `src/valid-phone.red`

#### **POC** - Prototype objects container

File: `src/poc.red`

Documentation: `docs/poc.md`

 Offers:

- assertions
- special assertions for expected errors
- data providers for testing a huge sets of data
- running tests from many files at once
