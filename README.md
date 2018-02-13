# Red particles

Pack of varied **tools** for **Red** language.

## Objects

### Prototype objects container 

**File** `src/poc.red`

**Purpose**

Ability to store objects safely in a *key-value* map, with access control and type checking. Currently `map!` can store anything, so *POC* will guarantee, that only objects will be stored. Fetching chosen element will return a clone of object prototype. 
