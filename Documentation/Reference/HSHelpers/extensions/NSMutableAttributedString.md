**EXTENSION**

# `NSMutableAttributedString`

## Properties
### `fullRange`

## Methods
### `init(string:link:)`

### `set(link:forText:)`

Add a link to a single substring in the string

- Parameters:
  - link: address to link to
  - textToFind: text to 'linkify'
- Returns: true if succesful

### `set(font:forText:)`

Set font for the string

- Parameters:
  - font: new font
  - textToFind: substring to adjust. Sets for the whole string if this is nil
- Returns: true if succesful

### `replaceOccurrences(of:with:options:)`

Replace substrings

- Parameters:
  - of: find
  - with: replace
  - options: search options

### `set(lineSpacing:paragraphSpacing:)`

Sets line spacing - but actually replaces whole paragraph style

- Parameter lineSpacing: spacing

### `set(alignment:)`

Set alignment - actually replaces whole paragraph style

- Parameter alignment: alignment

### `updateAttribute(_:value:range:)`

Updates a NSAttributedStringKey for a given range.
- Parameter _ name: A NSAttributedStringKey.
- Parameter value: Any type.
- Parameter range: A NSRange or nil to act on the whole string

### `updateAttributes(_:range:)`

Updates a Dictionary of NSAttributedStringKeys for a given range.
- Parameter _ attrs: A Dictionary of NSAttributedStringKey type keys and Any type values.
- Parameter range: A NSRange or nil to act on the whole string

### `removeAttributes(_:range:)`

Removes a Dictionary of NSAttributedStringKeys for a given range.
- Parameter _ attrs: An Array of attributedStringKeys.
- Parameter range: A NSRange or nil to act on the whole string
