# Tester 

Version: **0.0.6**

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [tester.red](../src/tester.red) | Main file - use it in your application |

## Description

Test framework for running tests of Red language scripts. Inspired by *PhpUnit*, *xUnit*, *nUnit* and other similar libraries.

"Tester" expects that you will give him a `object!`, which will contain test methods.
Each test method name should be started with word `test`. 

Optionally `setup` method will be executed before each test separately (only if `object!` consist method with name `setup`).

## Methods

* **Run** - Run all tests from provided object, which should consist at least one test method

```red
tester/run <object> 
```

## Assertions

* **Expect error** - mark that actually executed test should throw an error, other tests will not be affected

```red
tester/expect-error
```

* **Assert true** - test will fail, when value is not `true`

```red
tester/assert-true <value>
```

* **Assert false** - test will fail, when value is not `false`

```red
tester/assert-false <value>
```

* **Assert equals** - test will fail, when values of arguments are not equivalent

```red
tester/assert-equals <expected> <actual>
```

* **Assert not equals** - test will fail, when values of arguments are equivalent

```red
tester/assert-not-equals <expected> <actual>
```

* **Assert identical** - test will fail, when values have not identical address in memory

```red
tester/assert-identical <expected> <actual>
```

* **Assert not identical** - test will fail, when values have identical address in memory

```red
tester/assert-not-identical <expected> <actual>
```

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

## Features (Roadmap)
- [x] v **0.0.2** special assertion for expected error
- [x] v **0.0.3** logic assertions for tests
- [x] v **0.0.4** reducing tests execution time, using string buffer instead of console output
- [x] v **0.0.5 - 0.0.6** splitting script into modules
- [ ] v **0.0.7** adding original error trace when assertion failed
- [ ] v **0.0.8** running tests from many files at once
- [ ] v **0.0.9** redesigning the console output for statuses of tests
- [ ] v **0.1.0** data providers for testing a huge sets of data
- [ ] v **0.1.1** extending expected-error assertion by defining a type of error we expect
- [ ] v **0.1.2** simple mocks for objects and methods
- [ ] v **0.1.3** 'method' assertions for mocks - checking/expecting the mock method was executed
- [ ] v **0.1.4** 'argument' assertions for mock methods - checking/expecting an arguments of mock methods
- [ ] v **0.1.5** 'return' assertions for mock methods - forcing/expecting that mock method will return specific value
- [ ] v **0.1.6 - 0.1.9** refactoring, goal: increase execution time and readability
- [ ] v **0.2.0** redesigning an API of all public methods - goal: cohesion
- [ ] v **0.3.0** module to detect code coverage of tested objects