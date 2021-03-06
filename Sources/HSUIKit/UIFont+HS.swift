//
//  UIFont+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 07/09/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UIFont {
    func boldFont() -> UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold)!, size: self.pointSize)
    }
}

#endif
