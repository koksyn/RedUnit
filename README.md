# RedUnit

RedUnit is a free, open source **unit testing framework** for **Red** language.
Inspired by xUnit, nUnit, PhpUnit and other similar libraries.

### Motivation

The main reason is the possibility to building your own projects faster and easier.

The TDD (test driven-development) approach is now possible using the **RedUnit** tool, so you can eliminate bad cases at the early stage.

## Docs

* [Getting started](docs/getting-started.md) - usage, assertions and error handling

## Running the tests

The **RedUnit** unit test framework obviously can't test itself - so for now it does not have any tests. In the future releases I plan to write some simple scripts - to be able to test particular parts of RedUnit.

## Compatibility

Project was created and tested under **0.6.3** version of Red. Older versions were not tested.

## Features (Roadmap)
- [x] v **0.0.1-Snapshot** special assertion for expected error
- [x] v **0.0.1-Alpha1** logic assertions for tests
- [x] v **0.0.1-Alpha2** reducing tests execution time, using string buffer instead of console output
- [x] v **0.0.1-RC** splitting script into modules
- [x] v **0.0.1** Rebuilding whole project, because of dividing project into more repositories
- [x] v **0.0.2** running tests from many files at once
- [x] v **0.0.3** redesigning the console output for statuses of tests
- [ ] v **0.0.4** ability to mark tests as incomplete/skipped/risky
- [ ] v **0.0.5** data providers for testing a huge sets of data
- [ ] v **0.0.6** tests execution from compiled lib as CLI
- [ ] v **0.0.7** extending expected-error assertion by defining a type of error we expect
- [ ] v **0.0.8** simple mocks for objects and methods
- [ ] v **0.0.9** 'method' assertions for mocks - checking/expecting the mock method was executed
- [ ] v **0.1.0** 'argument' assertions for mock methods - checking/expecting an arguments of mock methods
- [ ] v **0.1.1** 'return' assertions for mock methods - forcing/expecting that mock method will return specific value
- [ ] v **0.1.2 - 0.1.9** refactoring, goal: increase execution time and readability
- [ ] v **0.2.0** redesigning an API of all public methods - goal: cohesion
- [ ] v **0.3.0** module to detect code coverage of tested objects

### Historical note

This tool was earlier a part of various tools, that I've created for Red language. When project became bigger, it was divided into a independent repositories like this.
