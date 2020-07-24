//
//  UIButton+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 17/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit

public extension UIButton {
    
    /// Adjust text to fit the button - allowing for multiline labels
    ///
    /// - Parameters:
    ///   - maxFontSize: in points
    ///   - minFontSize: in points
    func adjustFontSizeToFit(withMaxFontSize maxFontSize: CGFloat, minFontSize: CGFloat = 8) {

        guard let label = titleLabel else {
            return
        }
        
        let rect = self.bounds.insetBy(dx: titleEdgeInsets.left + titleEdgeInsets.right,
                                       dy: titleEdgeInsets.top + titleEdgeInsets.bottom)
        label.adjustFontSizeToFit(rect: rect, withMaxFontSize: maxFontSize, minFontSize: minFontSize)
    }
    
    convenience init(imageName:String, selectedImageName:String?) {
        guard let image = UIImage.init(named: imageName) else {
            fatalError("No image for button")
        }
        
        self.init(frame:CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        self.setImage(image, for: .normal)
        
        if let selectedImageName = selectedImageName,
            let selectedImage = UIImage.init(named: selectedImageName) {
            self.setImage(selectedImage, for: .highlighted)
        }
        
    }
    
    func setImageTitlePadding(_ imageTitlePadding:CGFloat){
        let contentPadding = self.contentEdgeInsets
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
}

#endif
#endif
