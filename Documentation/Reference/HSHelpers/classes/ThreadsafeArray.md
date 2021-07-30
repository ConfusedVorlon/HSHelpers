**CLASS**

# `ThreadsafeArray`

**Contents**

- [Properties](#properties)
  - `unsafeContents`
- [Methods](#methods)
  - `init(_:)`
  - `init(from:)`
  - `append(_:)`

Only one writer at a time - but asynchronous (flags: .barrier)
Multiple readers at a time
All queue items run in the order they are enqueued - so all writes will complete before a read runs

## Properties
### `unsafeContents`

## Methods
### `init(_:)`

### `init(from:)`

### `append(_:)`
