# Particles

Pack of varied **tools** for **Red language**.

The main reason is the possibility to building your own projects faster and easier.

By using **validators** for specific data you don't need to create them on you own. Moreover the TDD (test driven-development) approach is now possible using the **Tester** tool, so you can eliminate bad cases at the early stage. 

## Tools 

##### General-purpose

* [Tester](docs/tester.md) - Test framework with assertions and error handling. Inspired by xUnit, PhpUnit and other similar libraries.
* [POC](docs/poc.md) - Prototype objects container

##### Validators

* [VAT](docs/validators.md) - The Value Added Tax (VAT) in European Union, Latin American and other countries.

## Running the tests

### All tools at once

To run tests simply execute script `run-all-tests.red` from project main directory through **Red** binary.
This script will detect and execute all test files like `***-tests.red` under `/tests` directory.

```bash
./red -s run-all-tests.red
```

### One tool

All tests for specific tools are located under `/tests` directory.
Each tool have a file `TOOL-tests.red`, where `TOOL` should be replaced by tool name.

For example (VAT validator):
 
```bash
./red -s tests/valid-vat-tests.red
```

## Compatibility

Tools were created and tested under **0.6.3** version of Red. Older versions were not tested.