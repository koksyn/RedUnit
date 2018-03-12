# Particles

Pack of varied **tools** for **Red language**.

[![Travis build](https://travis-ci.org/koksyn/particles.svg?branch=master)](https://travis-ci.org/koksyn/particles)

### Motivation

The main reason is the possibility to building your own projects faster and easier.

By using **validators** for specific data you don't need to create them on you own. Moreover the TDD (test driven-development) approach is now possible using the **Tester** tool, so you can eliminate bad cases at the early stage. 

## Tools 

#### General-purpose

* [Tester](docs/tester.md) - Test framework with assertions and error handling. Inspired by xUnit, PhpUnit and other similar libraries.
* [POC](docs/poc.md) - Prototype objects container

#### Validators

* [VAT](docs/validators.md) - Value Added Tax in European Union, Latin American and other countries.
* [MAC](docs/validators.md) - Media access control address (for network interface controllers)
* [ISBN](docs/validators.md) - International Standard Book Number
* [Credit Card](docs/validators.md) - Credit Card numbers for several banks (VISA, Mastercard, etc.)
* [SEDOL](docs/validators.md) - Stock Exchange identifiers used in the United Kingdom and Ireland
* [SWIFT/BIC](docs/validators.md) - Business Identifier Codes for both financial or not-financial institutions

## Running the tests

The **Tester** test framework was used to test these tools, so obviously it can't test itself - that's the only tool without tests.

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
