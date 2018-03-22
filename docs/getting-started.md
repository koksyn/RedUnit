# RedUnit - Getting Started

Version: **0.0.1**

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [redunit.red](../src/redunit.red) | Main file - use it in your application |

## Description

Test framework for running tests of Red language scripts. Inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

**RedUnit** expects that you will give him a `object!`, which will contain test methods.
Each test method name should be started with word `test`. 

Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

## Methods

* **Run** - Run all tests from provided object, which should consist at least one test method

```red
redunit/run <object> 
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

```red
Red [
    File: %test.red
]

do %src/redunit.red

tests: context [
    setup: func [
        "Initialize/Reload context before each test"
    ] [
        do %src/utils/poc.red
    ]

    test-registered-item: func [
        "Testing that item was successfully registered"
    ] [
        book: object [title: "Red cookbook"]
        poc/register "my-book" book
        
        result: poc/registered "my-book"
        redunit/assert-true result
    ]
]

redunit/run tests
```

Console output:

```bash
./red -s test.red 
--------- RedUnit ----------
Version 0.0.1

[test] test-registered-item [Success]

Execution time: 0.004187 sec
---------------------------
```