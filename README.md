# Red particles

Pack of varied **tools** for **Red** language.

## Objects

### Prototype objects container 

Path: `src/poc.red`

Purpose: ability to store objects safely in a map, with access control and type checking. Currently `map!` can store anything, so *POC* will guarantee, that only objects will be stored.

Collects objects under identifiers as `key-value` map. Fetching chosen element will return a clone of object prototype. 
