## Prototype objects container 

File: [poc.red](../src/poc.red)

Tests: [poc-tests.red](../tests/poc-tests.red)

Code examples: [poc-examples.red](../examples/poc-examples.red)

### Purpose

Ability to store objects safely in a *key-value* map, with access control and type checking. 

Currently `map!` can store anything, so *POC* will guarantee, that only objects with type `object!` will be stored. 

### Usage

```red

do %../src/poc.red

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

### Methods

#### **Register** - put object to the container, identified by name

```red
poc/register <name> <prototype> 

; name - string! - unique identifier (case sensitive)
; prototype - object! - will be stored in the container
```

#### **Registered** - check, that identifier is already registered

```red
poc/registered <name> 

; name - string! - unique identifier
```

Returns `logic!`. Is true when identifier already exists, false otherwise.

#### **Replace** - replace object in the container

```red
poc/replace <name> <prototype>

; name - string! - unique identifier
; prototype - object! - will be replaced in the container
```

#### **Resolve** - get a clone of object prototype from container

```red
poc/resolve <name>

; name - string! - unique identifier
```

Returns `object!` - a clone of object prototype

#### **Remove** - remove object and identifier from container

```red
poc/resolve <name>

; name - string! - unique identifier
```