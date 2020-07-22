//
//  NSScreen+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 06/12/2018.
//


#if os(macOS)

import Foundation
import AppKit

public extension NSScreen {
    func applyWallpaper(fileURL:URL,scaling: NSImageScaling = NSImageScaling.scaleProportionallyUpOrDown, allowClipping:Bool? = true) throws {
        
        var options = [NSWorkspace.DesktopImageOptionKey.imageScaling :
            NSNumber.init(value: scaling.rawValue)]
        if let allowClipping = allowClipping {
            options[NSWorkspace.DesktopImageOptionKey.allowClipping] = NSNumber.init(booleanLiteral: allowClipping)
        }
        
        do {
            try NSWorkspace.shared.setDesktopImageURL(fileURL, for: self, options: options)
        } catch (let error) {
            print("Failed to set \(fileURL)")
            print("error: \(error)")
        }
        
        
    }
    
    func setToBlack() {
        let options = [
            NSWorkspace.DesktopImageOptionKey.imageScaling :NSNumber.init(value: NSImageScaling.scaleProportionallyUpOrDown.rawValue),
            NSWorkspace.DesktopImageOptionKey.allowClipping :NSNumber.init(value: true),
            NSWorkspace.DesktopImageOptionKey.fillColor :NSColor.black
                       ]
        
        try? NSWorkspace.shared.setDesktopImageURL(Bundle.main.bundleURL, for: self, options: options)
    }
    
    var displayID:CGDirectDisplayID? {
        let description = self.deviceDescription
        let displayIdKey = NSDeviceDescriptionKey.init("NSScreenNumber")
        return description[displayIdKey] as? CGDirectDisplayID
    }
}


extension Array where Element == NSScreen {
    
    var boundingRect:CGRect {
        guard self.count > 0 else {
            return .zero
        }
        
        return self.map{$0.frame}.boundingRect
    }
}

#endif
