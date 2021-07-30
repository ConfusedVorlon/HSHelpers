**CLASS**

# `ThreadsafeDict`

**Contents**

- [Properties](#properties)
  - `unsafeContents`
  - `keys`
- [Methods](#methods)
  - `init(_:)`
  - `init(from:)`
  - `removeValue(forKey:)`

Only one writer at a time - but asynchronous (flags: .barrier)
Multiple readers at a time
All queue items run in the order they are enqueued - so all writes will complete before a read runs

## Properties
### `unsafeContents`

### `keys`

## Methods
### `init(_:)`

### `init(from:)`

### `removeValue(forKey:)`
