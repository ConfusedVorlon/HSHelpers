//
//  UILabel+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 17/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UILabel {

    /// Adjust text to fit the label - allowing for multiline labels
    ///
    /// - Parameters:
    ///   - rect: uses bounds if nil, or skipped
    ///   - maxFont: max font
    ///   - minFontSize: min font
    func adjustFontSizeToFit(rect: CGRect? = nil, withMaxFontSize maxFont: CGFloat, minFontSize: CGFloat = 8) {

        guard let text = self.text else {
            return
        }

        let titleSize: CGSize = rect?.size ?? bounds.size
        var testFont: UIFont = self.font

        var index: Int = Int(maxFont)
        while CGFloat(i) > minFontSize {
            // Set the new font size.
            testFont = self.font.withSize(CGFloat(index))
            // You can log the size you're trying: NSLog(@"Trying size: %u", i);
            /* This step is important: We make a constraint box
             using only the fixed WIDTH of the UILabel. The height will
             be checked later. */
            let constraintSize = CGSize(width: titleSize.width, height: CGFloat.greatestFiniteMagnitude)
            // This step checks how tall the label would be with the desired font.

            let textRect: CGRect = text.boundingRect(with: constraintSize,
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: [NSAttributedString.Key.font: testFont],
                                                     context: nil)
            let labelSize = textRect.size

            /* Here is where you use the height requirement!
             Set the value in the if statement to the height of your UILabel
             If the label fits into your required height, it will break the loop
             and use that font size. */
            if (labelSize.height) <= titleSize.height {
                break
            }
            index -= 2
        }
        // You can see what size the function is using by outputting:
        // NSLog(@"Best size is: %u", i);
        // Set the UILabel's font to the newly adjusted font.

        self.font = testFont
    }

}

#endif
