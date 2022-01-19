//
//  UIColor+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 11/12/2019.
//  Copyright © 2019 HobbyistSoftware. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13, tvOS 13, *) {
            self.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            self.init(cgColor: light.cgColor)
        }
    }

}

#endif
