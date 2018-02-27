## Prototype objects container 

File: [poc.red](../src/poc.red)

Tests: [poc-tests.red](../tests/poc-tests.red)

Code examples: [poc-examples.red](../examples/poc-examples.red)

#### Purpose

Ability to store objects safely in a *key-value* map, with access control and type checking. 

Currently `map!` can store anything, so *POC* will guarantee, that only objects with type `object!` will be stored. 

#### Usage

##### Example 1: Adding and getting book by ISBN

```red

ISBN: "999-8-76-543210-1"
book: object [title: "Red cookbook"]

poc/register ISBN book

result: poc/resolve ISBN
probe result/title

```

Output:

```bash
"Red cookbook"
```

##### Example 2: Replacing book by the same ISBN

```red

green-book: object [title: "Green book"]

poc/replace ISBN green-book

result: poc/resolve ISBN
probe result/title

```

Output:

```bash
"Red cookbook"
```

#### Methods

##### **Register** - put object to the container, identified by name

```red
poc/register <name> <prototype> 
```

Params:

* `name` - type: `string!`, unique identifier (case sensitive)
* `prototype` - type: `object!`, object, which will be stored in the container

##### **Registered** - check, that identifier is already registered

```red
poc/registered <name> 
```

Params:

* `name` - type: `string!`, unique identifier (case sensitive)

Returns:

* `logic!` - is true when identifier already exists, false otherwise

##### **Replace** - replace object in the container

```red
poc/replace <name> <prototype>
```

Params:

* `name` - type: `string!`, unique identifier (case sensitive)
* `prototype` - type: `object!`, object, which will be stored in the container

##### **Resolve** - get a clone of object prototype from container

```red
poc/resolve <name>
```

Params:

* `name` - type: `string!`, unique identifier (case sensitive)

Returns:

* `object!` - a clone of object prototype

##### **Remove** - remove object and identifier from container

```red
poc/resolve <name>
```

Params:

* `name` - type: `string!`, unique identifier (case sensitive)