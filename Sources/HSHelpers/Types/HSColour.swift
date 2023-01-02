//
//  File.swift
//  
//
//  Created by Rob Jonson on 02/01/2023.
//

import Foundation


#if canImport(UIKit)
import UIKit
public typealias HSColour = UIColor
public typealias HSColor = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias HSColour = NSColor
public typealias HSColor = NSColor
#endif




//aliases for mac semantic colours so that we can use the iOS labels with HSColour in a cross platform app
//see https://developer.apple.com/design/human-interface-guidelines/foundations/color/
#if os(macOS)

public extension NSColor {
    
    //These are pretty obvious matches
    
    static let label = NSColor.labelColor
    static let secondaryLabel = NSColor.secondaryLabelColor
    static let tertiaryLabel = NSColor.tertiaryLabelColor
    static let quaternaryLabel = NSColor.quaternaryLabelColor
    static let placeholderText = NSColor.placeholderTextColor
    @available(macOS 10.14, *)
    static let separator = NSColor.separatorColor
    //static let opaqueSeparator - no obvious equivalent
    static let link = NSColor.linkColor
    
    //These are more of a stretch...
    static let systemBackground = NSColor.controlBackgroundColor
    static let secondarySystemBackground = NSColor.windowBackgroundColor
    
    //static let systemGray - already provided
    
    //The remaining grays simply match the iOS colours
    @available(macOS 10.15, *)
    static let systemGray2 = NSColor(name: Name("systemGray2")) { appearance in
        if appearance.isDark {
            return NSColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1)
        }
        else {
            return NSColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
        }
    }
    @available(macOS 10.15, *)
    static let systemGray3 = NSColor(name: Name("systemGray3")) { appearance in
        if appearance.isDark {
            return NSColor(red: 72/255, green: 72/255, blue: 74/255, alpha: 1)
        }
        else {
            return NSColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
        }
    }
    
    @available(macOS 10.15, *)
    static let systemGray4 = NSColor(name: Name("systemGray4")) { appearance in
        if appearance.isDark {
            return NSColor(red: 58/255, green: 58/255, blue: 60/255, alpha: 1)
        }
        else {
            return NSColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1)
        }
    }
    
    @available(macOS 10.15, *)
    static let systemGray5 = NSColor(name: Name("systemGray5")) { appearance in
        if appearance.isDark {
            return NSColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        }
        else {
            return NSColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        }
    }
    
    @available(macOS 10.15, *)
    static let systemGray6 = NSColor(name: Name("systemGray6")) { appearance in
        if appearance.isDark {
            return NSColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
        }
        else {
            return NSColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        }
    }
}

extension NSAppearance {
    var isDark:Bool {
        if #available(macOS 10.14, *) {
            return self.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        } else {
            return false
        }
    }
}

#endif
