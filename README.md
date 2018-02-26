# Red particles

Pack of varied **tools** for **Red** language.

### Tests for tools

To run tests simply execute script `run-all-tests.red` from project main directory through **Red** binary.
This script will detect and execute all test files like `***-tests.red` under `/tests` directory.

```bash
./red -s run-all-tests.red
```

## Tools 
 
### **Tester** - Testing tool

File: `src/tester.red`

Documentation: `docs/tester.md`

Tool for running tests of Red language scripts inspired by PhpUnit, xUnit, nUnit and other similar libraries. Offers:

- assertions
- special assertions for expected errors
- data providers for testing a huge sets of data
- running tests from many files at once

### **Validators** - Check provided code is valid

Files: `src/valid-***.red`

Documentation: `docs/validators.md`

Tool for checking codes:

- VAT numbers from EU, Latin America and other countires - `src/valid-vat.red`
- Phone numbers for various countries - `src/valid-phone.red`

### **POC** - Prototype objects container

File: `src/poc.red`

Documentation: `docs/poc.md`

Tool for running tests of Red language scripts inspired by PhpUnit, xUnit, nUnit and other similar libraries. Offers:

- assertions
- special assertions for expected errors
- data providers for testing a huge sets of data
- running tests from many files at once
