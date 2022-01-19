//
//  NSMutableAttributedString+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 20/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

#if !os(macOS)
import UIKit
#endif

#if os(iOS) || os(tvOS) || os(watchOS)
    public typealias FontCompat = UIFont
#elseif os(OSX)
    import AppKit
    public typealias FontCompat = NSFont
#endif

public extension NSAttributedString {
    #if os(macOS)
    convenience init?(htmlString: String) {
        if let data = htmlString.data(using: .utf16, allowLossyConversion: false) {
            self.init(html: data, documentAttributes: nil)
        } else {
            return nil
        }

    }
    #endif
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString.init(attributedString: self)
    }
}

public extension NSMutableAttributedString {

    var fullRange: NSRange {
        return NSRange(location: 0, length: self.length)
    }

    convenience init(string: String, link: String?) {
        self.init(string: string)
        if let link = link {
            self.set(link: link)
        }
    }

    @discardableResult
    /// Add a link to a single substring in the string
    ///
    /// - Parameters:
    ///   - link: address to link to
    ///   - textToFind: text to 'linkify'
    /// - Returns: true if succesful
    func set(link: String, forText textToFind: String? = nil ) -> Bool {

        var foundRange = fullRange
        if let textToFind = textToFind {
            foundRange = self.mutableString.range(of: textToFind)
        }

        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: link, range: foundRange)
            return true
        }
        return false
    }

    @discardableResult
    /// Set font for the string
    ///
    /// - Parameters:
    ///   - font: new font
    ///   - textToFind: substring to adjust. Sets for the whole string if this is nil
    /// - Returns: true if succesful
    func set(font: FontCompat, forText textToFind: String? = nil) -> Bool {

        var foundRange = fullRange
        if let textToFind = textToFind {
            foundRange = self.mutableString.range(of: textToFind)
        }

        if foundRange.location != NSNotFound {
            self.addAttribute(.font, value: font, range: foundRange)
            return true
        }
        return false
    }

    /// Replace substrings
    ///
    /// - Parameters:
    ///   - of: find
    ///   - with: replace
    ///   - options: search options
    func replaceOccurrences(of: String, with: String, options: NSString.CompareOptions = [.literal]) {
        self.mutableString.replaceOccurrences(of: of, with: with, options: options, range: fullRange)
    }

    /// Sets line spacing - but actually replaces whole paragraph style
    ///
    /// - Parameter lineSpacing: spacing
    func set(lineSpacing: CGFloat, paragraphSpacing: CGFloat? = nil) {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.paragraphSpacing = paragraphSpacing ?? lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.paragraphStyle: paragraphStyle]

        self.updateAttributes(attributes, range: fullRange)
    }

    /// Set alignment - actually replaces whole paragraph style
    ///
    /// - Parameter alignment: alignment
    func set(alignment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment

        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: fullRange)
    }

    // copied from Material
    /**
     Updates a NSAttributedStringKey for a given range.
     - Parameter _ name: A NSAttributedStringKey.
     - Parameter value: Any type.
     - Parameter range: A NSRange or nil to act on the whole string
     */
    func updateAttribute(_ name: NSAttributedString.Key, value: Any, range: NSRange? = nil) {
        let calculatedRange = range ?? fullRange

        removeAttribute(name, range: calculatedRange)
        addAttribute(name, value: value, range: calculatedRange)
    }

    /**
     Updates a Dictionary of NSAttributedStringKeys for a given range.
     - Parameter _ attrs: A Dictionary of NSAttributedStringKey type keys and Any type values.
     - Parameter range: A NSRange or nil to act on the whole string
     */
    func updateAttributes(_ attrs: [NSAttributedString.Key: Any], range: NSRange? = nil) {
        let calculatedRange = range ?? fullRange

        for (k, v) in attrs {
            updateAttribute(k, value: v, range: calculatedRange)
        }
    }

    /**
     Removes a Dictionary of NSAttributedStringKeys for a given range.
     - Parameter _ attrs: An Array of attributedStringKeys.
     - Parameter range: A NSRange or nil to act on the whole string
     */
    func removeAttributes(_ attrs: [NSAttributedString.Key], range: NSRange? = nil) {
        let calculatedRange = range ?? fullRange

        for k in attrs {
            removeAttribute(k, range: calculatedRange)
        }
    }

}
