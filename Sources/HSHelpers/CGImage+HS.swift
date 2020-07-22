//
//  CGImage+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 04/05/2020.
//

import Foundation
import CoreGraphics
import ImageIO
import CoreServices

public extension CGImage {
    
    
    /// Image size
    var size:CGSize {
        return CGSize.init(width: self.width, height: self.height)
    }
    
    
    /// Create CGImage from url
    /// - Parameter url: source URL
    /// - Returns: optional CGImage
    static func imageFrom(url:URL) -> CGImage? {

        return autoreleasepool { () -> CGImage? in
            let options = [kCGImageSourceShouldCache:false]
            guard let source = CGImageSourceCreateWithURL(url as CFURL, options as CFDictionary) else {
                return nil
            }
            
            return CGImageSourceCreateImageAtIndex(source,0,nil)
        }

    }
    
    /// Create CGImage from data
    /// - Parameter data: source data
    /// - Returns:  optional CGImage
    static func imageFrom(data:Data) -> CGImage? {

        return autoreleasepool { () -> CGImage? in
            let options = [kCGImageSourceShouldCache:false]
            guard let source = CGImageSourceCreateWithData(data as CFData, options as CFDictionary) else {
                return nil
            }
            
            return CGImageSourceCreateImageAtIndex(source,0,nil)
        }

    }
    

    /// Write out a png
    /// - Parameter to: destination fileURL
    /// - Returns: success
    func writePNG(to:URL) -> Bool {
        autoreleasepool {
            guard let dest = CGImageDestinationCreateWithURL(to as CFURL,kUTTypePNG,1, nil) else {
                return false
            }
            
            CGImageDestinationAddImage(dest, self,nil)
            return CGImageDestinationFinalize(dest)
        }
    }
    
    func pngData() -> Data? {
        autoreleasepool {
            let data = NSMutableData()
            let imageDestinationRef = CGImageDestinationCreateWithData(data as CFMutableData, kUTTypePNG, 1, nil)!
            CGImageDestinationAddImage(imageDestinationRef, self, nil)
            CGImageDestinationFinalize(imageDestinationRef)
            return data as Data
        }
    }
    
    /// Make image from all or part of self
    /// - Parameters:
    ///   - size: size of resulting image
    ///   - fromRect: source rect (does not need to be within the image)
    ///   - hasAlpha: whether the result should have an alpha channel
    ///   - backgroundColour: if the image doesn't have an alpha channel, then this fill is applied 'behind' the image
    /// - Returns: optional CGImage
    func makeImage(size:CGSize,fromRect:CGRect? = nil, hasAlpha:Bool = true, backgroundColour:CGColor = .white) -> CGImage? {
        
        autoreleasepool {
            () -> CGImage? in
            
            let rect = fromRect ?? CGRect(x: 0, y: 0, width: width, height: height)
            
            let scaleWidth:CGFloat = size.width / rect.width
            let scaleHeight:CGFloat = size.height / rect.height
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let bitmapInfo = hasAlpha ? CGImageAlphaInfo.premultipliedLast : CGImageAlphaInfo.noneSkipLast
            
            if let context = CGContext(data: nil,
                                       width: Int(size.width), height: Int(size.height),
                                       bitsPerComponent: self.bitsPerComponent,
                                       bytesPerRow: 0,
                                       space: colorSpace,
                                       bitmapInfo: bitmapInfo.rawValue) {
                
                if !hasAlpha {
                    let rect = CGRect.init(origin: .zero, size: size)
                    context.setFillColor(backgroundColour)
                    context.fill(rect)
                }
                
                let destinationRect = CGRect(x: -rect.origin.x * scaleWidth,
                                             y:-rect.origin.y * scaleHeight,
                                             width: CGFloat(self.width) * scaleWidth,
                                             height: CGFloat(self.height) * scaleHeight)
                
                context.draw(self, in: destinationRect)
                return context.makeImage()
                
            }
            else {
                print("ERROR: Unable to create image context")
                return nil
            }

        }
        
        
        
    }
}
