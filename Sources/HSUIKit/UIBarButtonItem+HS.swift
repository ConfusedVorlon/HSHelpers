//
//  UIBarButtonItem+HS.swift
//  Off
//
//  Created by Rob Jonson on 20/04/2020.
//

#if !os(watchOS)
#if canImport(UIKit)


import Foundation
import UIKit

public extension UIBarButtonItem {

    var frame: CGRect? {
        guard let view = self.value(forKey: "view") as? UIView else {
            return nil
        }
        return view.frame
    }

}


#endif
#endif
