**EXTENSION**

# `UIView`

## Methods
### `border(width:colour:)`

### `forAutoLayout()`

### `shadow(height:colour:)`

### `hsOffscreenImage(scale:afterScreenUpdates:)`

offscreen capture. Seems to be marginally faster than hsOffscreenImage
requires main thread

If this doesn't work, that probably means the layer is the wrong size.
This can happen with autolayout views taken offscreen

- parameter scale:  scale to render
- parameter opaque: if opaque, then background has black layer

- returns: image

### `hsOffscreenImage2(scale:opaque:)`

offscreen capture. Seems to be marginally faster than hsOffscreenImage
works in background thread

- parameter scale:  scale to render
- parameter opaque: if opaque, then background has black layer

- returns: image

### `useFadeToAnimateLayer(duration:)`

### `removeSubviews()`

### `addConstraints(withVisualFormat:options:metrics:views:)`
