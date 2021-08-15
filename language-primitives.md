# Language primitives

### Tuples

- A tuple is a grouping of values
- A 0-tuple represents the absence of value
- A 1-tuple represents the value itself
- An n-tuple of 2 or more values represents the sequence of those values, implicitly keyed by whole numbers in ascending order starting from 0, optionally also keyed by identifers

### Collections

- A collection is the fundamental data structure
- Values may be assigned to keys within a collection
- Keys are either identifiers, strings or whole numbers
- A collection of values whose keys are whole numbers is an array
- A collection of values defined without keys is implicitly keyed by whole numbers in ascending order starting from 0
- A collection may be the prototype of another collection, through delegation

### Blocks

- A block is the fundamental unit of computation
- Values may be assigned to identifiers within a block, being lexically scoped at the block level
- A block evaluates to the value of its last evaluated expression
- A file is a module is a block

### Functions

- A function is the fundamental callable unit of computation
- It is a special kind of _collection_ that maps a parameter definition (a _tuple_) to a _block_
- When applied to (called with) a value, the function's _block_ is evaluated with the value as its argument, having closure
- A function may accept zero or multiple values by using a _tuple_
