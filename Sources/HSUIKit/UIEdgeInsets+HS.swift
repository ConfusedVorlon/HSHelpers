//
//  UIEdgeInsets+HS.swift
//  Rhythm101
//
//  Created by Rob Jonson on 16/01/2017.
//  Copyright © 2017 Tinkerswitch. All rights reserved.
//


#if canImport(UIKit)

import Foundation
import UIKit

public extension UIEdgeInsets {
    init(margin: CGFloat){
        self.init(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    init(sides:CGFloat,topBottom:CGFloat){
        self.init(top: topBottom, left: sides, bottom: topBottom, right: sides)
    }
}

#endif

