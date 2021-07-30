**EXTENSION**

# `Result`

## Properties
### `isSuccess`

### `isFailure`

Returns whether the instance is `.failure`.

### `success`

Returns the associated value if the result is a success, `nil` otherwise.

### `failure`

Returns the associated error value if the result is a failure, `nil` otherwise.

### `voidResult`

Essentially type coercion where you don't care about the success object
