**EXTENSION**

# `FileManager`

## Properties
### `documentsDirectoryURL`

### `documentsDirectory`

### `cachesDirectory`

## Methods
### `createTemporaryDirectory(folderName:)`

Creates directory in NSTemporary directory
- Parameter folderName: if present, creates subdirectory with given name e.g. tmp/uuid/folderName
- Throws: createDirectory
- Returns: url of new directory

### `sizeOfFile(atPath:)`

### `sizeOfFile(atURL:)`

### `modificationDateOfFile(atPath:)`

### `modificationDateOfFile(atURL:)`

### `fileIsDirectory(atPath:)`

### `fileIsDirectory(atURL:)`

### `save(data:fullFilename:createDirectory:allowEmpty:)`

### `uniquePath(fromBase:)`

### `uniqueFileURL(fromBase:)`
