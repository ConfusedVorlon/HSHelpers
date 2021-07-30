**EXTENSION**

# `CGImage`

## Properties
### `size`

Image size

## Methods
### `imageFrom(url:)`

Create CGImage from url
- Parameter url: source URL
- Returns: optional CGImage

### `imageFrom(data:)`

Create CGImage from data
- Parameter data: source data
- Returns:  optional CGImage

### `writePNG(to:)`

Write out a png
- Parameter to: destination fileURL
- Returns: success

### `pngData()`

### `makeImage(size:fromRect:hasAlpha:backgroundColour:)`

Make image from all or part of self
- Parameters:
  - size: size of resulting image
  - fromRect: source rect (does not need to be within the image)
  - hasAlpha: whether the result should have an alpha channel
  - backgroundColour: if the image doesn't have an alpha channel, then this fill is applied 'behind' the image
- Returns: optional CGImage
