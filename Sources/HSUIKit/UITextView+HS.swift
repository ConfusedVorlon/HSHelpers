//
//  UITextView+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 14/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit
import HSHelpers

public extension UITextView {
    @discardableResult
    /// Set font for the string
    ///
    /// - Parameters:
    ///   - font: new font
    ///   - textToFind: substring to adjust. Sets for the whole string if this is nil
    /// - Returns: true if succesful
    public func set(font:UIFont, forText textToFind:String? = nil) -> Bool {
        
        if let text = self.attributedText {
                    let mutableText:NSMutableAttributedString = NSMutableAttributedString.init(attributedString: text)
            return mutableText.set(font: font, forText: textToFind)
        }
        else {
            return false
        }
    }
}

#endif
#endif
