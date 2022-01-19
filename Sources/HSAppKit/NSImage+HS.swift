//  Converted to Swift 4 by Swiftify v4.2.29618 - https://objectivec2swift.com/
//
//  NSImage+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 14/11/2018.
//
//
//  UIScreen.m
//  timer1
//
//  Created by Rob Jonson on 08/09/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#if os(macOS)

import AppKit
import CoreGraphics

public extension NSImage {

    /// Return a part of the image
    ///
    /// - Parameter rect: rect to return
    /// - Returns: partial image
    func from(rect: NSRect) -> NSImage? {
        if !rect.isPositive {
            return nil
        }

        let canvasFrame: NSRect = NSRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        let canvas = NSImage(size: canvasFrame.size)
        canvas.lockFocus()
        draw(in: canvasFrame, from: rect, operation: .copy, fraction: 1, respectFlipped: true, hints: nil)
        canvas.unlockFocus()
        return canvas
    }

    func pngRepresentation(size requiredSize: NSSize? = nil) -> Data? {

        let newSize = requiredSize ?? size

        let sizedImage: NSImage? = singlePixelImage(with: newSize)
        // create a NSBitmapImageRep
        var bmpImageRep: NSBitmapImageRep?
        if let aRepresentation = sizedImage?.tiffRepresentation {
            bmpImageRep = NSBitmapImageRep(data: aRepresentation)
        }
        // get the data from the representation
        let data: Data? = bmpImageRep?.representation(using: NSBitmapImageRep.FileType.png, properties: [:])
        return data
    }

    func jpegRepresentation(compression: Float = 1.0, size requiredSize: NSSize? = nil) -> Data? {
        let newSize = requiredSize ?? size

        let sizedImage: NSImage? = singlePixelImage(with: newSize)
        // create a NSBitmapImageRep
        var bmpImageRep: NSBitmapImageRep?
        if let aRepresentation = sizedImage?.tiffRepresentation {
            bmpImageRep = NSBitmapImageRep(data: aRepresentation)
        }
        let propertyDictionary: [NSBitmapImageRep.PropertyKey: Any] = [.compressionFactor: compression]
        // get the data from the representation
        var data: Data?

        data = bmpImageRep?.representation(using: NSBitmapImageRep.FileType.jpeg, properties: propertyDictionary)

        return data
    }

    /// Scales image. Aspect ratio is maintained if exactly one of width or height are non-nil
    /// - Parameters:
    ///   - width: new width
    ///   - height: new height
    /// - Returns: scaled image
    func scaledTo(width: CGFloat?, height: CGFloat?) -> NSImage? {
        if size.width == 0 || size.height == 0 {
            print("Can't scale image with zero dimension")
            return nil
        }

        if let width = width {
            if let height = height {
                return singlePixelImage(with: NSSize(width: width, height: height))
            } else {
                let newSize = NSSize(width: width, height: size.height * width / size.width)
                return singlePixelImage(with: newSize)
            }
        } else {
            if let height = height {
                let newSize = NSSize(width: size.width * height / size.height, height: height)
                return singlePixelImage(with: newSize)
            } else {
                assert(false, "Must provide width or height")
                return nil
            }
        }

    }

    // inspired by http://vocaro.com/trevor/blog/wp-content/uploads/2009/10/UIImage+Resize.m
    func singlePixelImage(with size: NSSize) -> NSImage? {

        var proposedRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        guard let imageRef = cgImage(forProposedRect: &proposedRect, context: nil, hints: nil) else {
                return nil
        }

        // Build a context that's the same dimensions as the new size
        // from the docs - The constants for specifying the alpha channel information are declared with the CGImageAlphaInfo type but can be passed to this parameter safely.
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        guard let context = CGContext(data: nil,
                                width: size.width.int, height: size.height.int,
                                bitsPerComponent: imageRef.bitsPerComponent,
                                bytesPerRow: 0,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
                                    print("ERROR: Unable to create image context")
                                    return nil
        }

        // Draw into the context; this scales the image
        context.draw(imageRef, in: NSRect(x: 0, y: 0, width: size.width, height: size.height))

        // Get the resized image from the context and a UIImage
        guard let newImageRef = context.makeImage() else {
            print("no image returned from context")
            return nil
        }
        let croppedImage = NSImage(cgImage: newImageRef, size: size)

        return croppedImage
    }

    var cgImage: CGImage? {
        return cgImage(forProposedRect: nil, context: nil, hints: nil)
    }

    func imageRotatedByDegreess(degrees: CGFloat) -> NSImage {

        var imageBounds = NSRect.zero ; imageBounds.size = self.size

        let pathBounds = NSBezierPath(rect: imageBounds)
        var transform = NSAffineTransform()
        transform.rotate(byDegrees: degrees)
        pathBounds.transform(using: transform as AffineTransform)
        let rotatedBounds: NSRect = NSRect(x: NSPoint.zero.x, y: NSPoint.zero.y, width: self.size.width, height: self.size.height)
        let rotatedImage = NSImage(size: rotatedBounds.size)

        // Center the image within the rotated bounds
        imageBounds.origin.x = rotatedBounds.midX - (imageBounds.width / 2)
        imageBounds.origin.y  = rotatedBounds.midY - (imageBounds.height / 2)

        // Start a new transform
        transform = NSAffineTransform()
        // Move coordinate system to the center (since we want to rotate around the center)
        transform.translateX(by: +(rotatedBounds.width / 2 ), yBy: +(rotatedBounds.height / 2))
        transform.rotate(byDegrees: degrees)
        // Move the coordinate system bak to normal
        transform.translateX(by: -(rotatedBounds.width / 2 ), yBy: -(rotatedBounds.height / 2))
        // Draw the original image, rotated, into the new image
        rotatedImage.lockFocus()
        transform.concat()
        self.draw(in: imageBounds, from: NSRect.zero, operation: NSCompositingOperation.copy, fraction: 1.0)
        rotatedImage.unlockFocus()

        return rotatedImage
    }
}

#endif
