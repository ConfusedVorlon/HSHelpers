//
//  UIImageView+HS.swift
//  VLCRemote2
//
//  Created by Rob Jonson on 03/12/2019.
//


#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit

public extension UIImageView {

    convenience init(imageNamed:String,highlightedImageNamed:String? = nil) {
        let image = UIImage(named: imageNamed)
        var highlightedImage:UIImage?
        if let highlightedImageNamed = highlightedImageNamed {
            highlightedImage = UIImage(named: highlightedImageNamed)
        }
        self.init(image: image,highlightedImage:highlightedImage)
    }
    
}

#endif
#endif
