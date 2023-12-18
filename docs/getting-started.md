# RedUnit - Getting Started

Version: **0.0.3**

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [redunit.red](../src/redunit.red) | Main file - use it in your application |

## Description

Test framework for running tests of Red language scripts. Inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

**RedUnit** expects that you will give him a filepath (`file!`) to Red script with `object!`, which will contain test methods.
Each test method name should be started with word `test`.

Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

You can also give a path (`file!`) to the directory. Then all files, whose matches the pattern `<prefix>***<postfix>.red`
will be loaded and tested. Furthermore subdirectories will be also recursively scanned.

## Methods

* **Run** - Will detect and execute all `<prefix>***<postfix>.red` test objects under `<dir>` directory

```red
redunit/run <dir>
```

Or will execute only a test object from a provided file

```red
redunit/run <file>
```

* **Set test filename prefix** - by default `prefix: ""`

```red
redunit/set-test-filename-prefix <prefix>
```

* **Set test filename postfix** - by default `postfix: "-tests"`

```red
redunit/set-test-filename-postfix <postfix>
```

## Assertions

* **Expect error** - mark that actually executed test should throw an error, other tests will not be affected

```red
redunit/expect-error
```

* **Assert true** - test will fail, when value is not `true`

```red
redunit/assert-true <value>
```

* **Assert false** - test will fail, when value is not `false`

```red
redunit/assert-false <value>
```

* **Assert equals** - test will fail, when values of arguments are not equivalent

```red
redunit/assert-equals <expected> <actual>
```

* **Assert not equals** - test will fail, when values of arguments are equivalent

```red
redunit/assert-not-equals <expected> <actual>
```

* **Assert identical** - test will fail, when values have not identical address in memory

```red
redunit/assert-identical <expected> <actual>
```

* **Assert not identical** - test will fail, when values have identical address in memory

```red
redunit/assert-not-identical <expected> <actual>
```

## Usage

Create a file with testable `context`

```red
Red [
    File: %examples/tests/poc-tests.red
]

context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %../../src/utils/poc.red
        point: context [ x:1 y:2 z:3 ]
    ]

    test-register-same-object-twice: func [
        "Registering same object twice should be possible"
    ] [
        poc/register "first" point
        poc/register "second" point
    ]

    test-register-same-name-twice: func [
        "Registering the same name twice is forbidden"
    ] [
        poc/register "twice" point

        redunit/expect-error
        poc/register "twice" point
    ]

    test-was-registered: func [
        "Checking name was registered before and after registration"
    ] [
        redunit/assert-false poc/registered "my-point"
        poc/register "my-point" point
        redunit/assert-true poc/registered "my-point"
    ]

    test-resolve-unregistered-name: func [
        "Resolving unregistered name is forbidden"
    ] [
        redunit/expect-error
        poc/resolve "unknown" point
    ]

    test-resolve-returned-prototype-clone: func [
        "Resolving registered name should return Prototype clone"
    ] [
        poc/register "my-point" point
        result: poc/resolve "my-point"

        redunit/assert-equals point result
        redunit/assert-not-identical point result
    ]
]
```

Then you can run tests on this file from another place

```red
Red [
    File: %examples/run-one-file.red
]

; load RedUnit
do %../src/redunit.red

; Execute tests
redunit/run %tests/poc-tests.red
```

Console output:

```bash
./red-063-linux -s examples/run-one-file.red
┌────────────────┐
│ RedUnit v0.0.3 │
└────────────────┘

.............

┌─               ─┐
│ Status: Success │
└─               ─┘
Time: 79.855 ms
13 tests, 11 assertions

```

## Console output sequence of characters

In the console output you will see a sequence of characters, whose are eqivalent of current tests execution status.

* **. (dot)** - actually executed single test passed checking without errors

Example (10 successful tests = 10 dots)
```red
..........
```

* **F (letter)** - actually executed single test failed and contain errors

Example (6 successful tests - 6 dots, 4 failed tests - 4 "F" letters)
```red
FF...F...F
```

## Examples of failed tests

### Caused by assertions (example 1)

```bash
./red-063-linux examples/run-directory.red
┌────────────────┐
│ RedUnit v0.0.3 │
└────────────────┘

FF.............

┌─      ─┐
│ Errors │
└─      ─┘

│ File      : tests/simple-tests.red
│ Method    : test-different-values
│ Assertion : not-equals

Expected different values, but they are equivalent.

│ File      : tests/simple-tests.red
│ Method    : test-error-thrown
│ Assertion : error-expected

Expected error, but nothing happen.

┌─               ─┐
│ Status: Failure │
└─               ─┘
Time: 84.951 ms
13 tests, 13 assertions, 2 errors

```

### Caused by unexpected user errors (example 2)

```bash
┌────────────────┐
│ RedUnit v0.0.3 │
└────────────────┘

........F......

┌─      ─┐
│ Errors │
└─      ─┘

│ File      : tests/poc-tests.red
│ Method    : test-replace-unregistered-name

Runtime error detected, but there was not any assertion dedicated for expecting error.

*** User Error: "Can not replace an unregistered object"
*** Where: do
*** Stack: rejoin first last cause-error

┌─               ─┐
│ Status: Failure │
└─               ─┘
Time: 80.88 ms
13 tests, 12 assertions, 1 error

```