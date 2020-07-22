//  Converted to Swift 4 by Swiftify v4.2.29618 - https://objectivec2swift.com/
//
//  NSView+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 14/11/2018.
//

#if os(macOS)

import AppKit
import HSHelpers

public extension NSView {
    
    class func autolayout() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    
    var center:NSPoint {
        get {
            return frame.center
        }
        set {
            let newOrigin:NSPoint = newValue - (frame.size / 2)
            setFrameOrigin(newOrigin)
            needsDisplay = true
        }
        
    }

    
    func bringSubviewToFront(_ view: NSView) {
            var theView = view
            self.sortSubviews({(viewA,viewB,rawPointer) in
                let view = rawPointer?.load(as: NSView.self)
                
                switch view {
                case viewA:
                    return ComparisonResult.orderedDescending
                case viewB:
                    return ComparisonResult.orderedAscending
                default:
                    return ComparisonResult.orderedSame
                }
            }, context: &theView)
    }
    
    func sortSubviewToBack(_ view: NSView) {
        var theView = view
        self.sortSubviews({(viewA,viewB,rawPointer) in
            let view = rawPointer?.load(as: NSView.self)
            
            switch view {
            case viewA:
                return ComparisonResult.orderedAscending
            case viewB:
                return ComparisonResult.orderedDescending
            default:
                return ComparisonResult.orderedSame
            }
        }, context: &theView)
    }
    
    func sendSubviewToBack(_ view: NSView) {
        view.removeFromSuperview()
        addSubview(view, positioned: .below, relativeTo: nil)
    }
    
    func removeSubviews() {
        let views = subviews
        for view: NSView in views {
            view.removeFromSuperview()
        }
    }
    
    func logSubviews(indent:Int = 0) {
        let indentString = String(repeating: " ", count:indent)
        
        for subview: NSView in subviews {
            print("\(subview.tag) \(indentString) view:\(subview) frame:\(subview.frame) bounds\(subview.bounds)")

            subview.logSubviews(indent: indent + 1)
        }
    }
    
    func setBackgroundColor(_ color: NSColor) {
        wantsLayer = true
        layer?.backgroundColor = color.cgColor
    }
    
    @discardableResult
    func insertVibrancyView(blendingMode: NSVisualEffectView.BlendingMode = .behindWindow) -> NSView? {
        if #available(OSX 10.13, *) {
            
            let vibrant = NSVisualEffectView(frame: bounds)
            vibrant.autoresizingMask = [.width, .height]
            vibrant.blendingMode = blendingMode

            addSubview(vibrant, positioned: .below, relativeTo: nil)
 
            return vibrant
        }

        return nil
    }
    
    func imageWithSubviews() -> NSImage? {
        let mySize: NSSize = bounds.size
        let imgSize: NSSize = NSMakeSize(mySize.width, mySize.height)
        let bir: NSBitmapImageRep? = bitmapImageRepForCachingDisplay(in: bounds)
        bir?.size = imgSize
        if let aBir = bir {
            cacheDisplay(in: bounds, to: aBir)
        }
        let image = NSImage(size: imgSize)
        if let aBir = bir {
            image.addRepresentation(aBir)
        }
        return image
    }
    
    func setBorder(width: Float, colour: NSColor?) {
        layer?.borderWidth = CGFloat(width)
        layer?.borderColor = colour?.cgColor
    }
    
    
    var recursiveSubviews:[NSView] {
        var views = subviews
        for view in subviews {
            views.append(contentsOf:view.recursiveSubviews)
        }
        return views
    }
}


#endif
