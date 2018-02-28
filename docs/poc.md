# Prototype objects container 

| File                       | Description  |
| ----------------------------- | ------------------------ |
| [poc.red](../src/poc.red) | Main file - use it in your application |
| [poc-tests.red](../tests/poc-tests.red) | Tests for this tool |
| [poc-examples.red](../examples/poc-examples.red) | Example usage as Red script |

## Description

The main goal was ability to store objects safely in a *key-value* map, with access control and type checking. 

Currently `map!` can store anything, so *POC* will guarantee, that only objects with type `object!` will be stored. 
Identifiers are case sensitive and they should be unique for each object.

## Methods

* **Register** - put object to the container, identified by name

```red
poc/register <name> <object> 
```

* **Registered** - check, that identifier is already registered. Returns `logic!`

```red
poc/registered <name>
```

* **Replace** - replace object in the container to another

```red
poc/replace <name> <object>
```

* **Resolve** - get a clone of object prototype from container

```red
poc/resolve <name>
```

* **Remove** - removes object and identifier from container

```red
poc/remove <name>
```

## Usage

```red

do %src/poc.red

; ------------------------------------------------------
; Example 1: Adding and getting book by ISBN
; ------------------------------------------------------
 
ISBN: "999-8-76-543210-1"
book: object [title: "Red cookbook"]

poc/register ISBN book

result: poc/resolve ISBN
probe result/title

; Output:
; "Red cookbook"

; ------------------------------------------------------
; Example 2: Replacing book by the same ISBN
; ------------------------------------------------------
 
green-book: object [title: "Green book"]

poc/replace ISBN green-book

result: poc/resolve ISBN
probe result/title

; Output:
; "Green book"

; ------------------------------------------------------
; Example 3: Removing book and checking it does exist
; ------------------------------------------------------

probe poc/registered ISBN

; Output:
; true

poc/remove ISBN
probe poc/registered ISBN

; Output:
; false

; ------------------------------------------------------
; Handling errors
; ------------------------------------------------------
 
either error? result: try [poc/resolve "unknown-identifier"] [
    print ["Error message: " result/arg1]
] [
    print ["Everything fine! Your object: " result]
]

; Output:
; Error message:  Can not resolve an unregistered object

```