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
    
    var deviceName:String? {
        guard let displayID = displayID else {
            return nil
        }

        guard let ioServicePort = displayID.getIOService() else  {
            print("can't get valid service for \(displayID).")
            return nil
        }
        
        defer {
            IOObjectRelease(ioServicePort)
        }

        guard let info = IODisplayCreateInfoDictionary(ioServicePort, UInt32(kIODisplayOnlyPreferredName)).takeRetainedValue() as? [String: AnyObject] else {
            print("IODisplayCreateInfoDictionary unexpected format")
            return nil
        }

        if let productName = info["DisplayProductName"] as? [String: String],
            let firstKey = Array(productName.keys).first {
            return productName[firstKey]!
        }

        return nil
    }
    
    var serialNumber:UInt32? {
        guard let displayID = displayID else {
            return nil
        }
        
        let serial = CGDisplaySerialNumber(displayID)
        
        //see docs for CGDisplaySerialNumber
        if serial == 0 || serial == 0xFFFFFFFF{
            return nil
        }

        return serial
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
