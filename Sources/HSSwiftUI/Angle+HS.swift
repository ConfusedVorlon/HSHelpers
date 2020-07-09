//
//  Angle+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 15/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//


#if canImport(SwiftUI)

import Foundation
import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension Angle {
    static func * (lhs: Angle, rhs: Double) -> Angle {
        return Angle(degrees: lhs.degrees * rhs)
    }
    
    static func * (lhs: Double, rhs: Angle) -> Angle {
        return Angle(degrees: rhs.degrees * lhs)
    }
    
    static func * (lhs: Angle, rhs: Int) -> Angle {
        return Angle(degrees: lhs.degrees * Double(rhs))
    }
    
    static func * (lhs: Int, rhs: Angle) -> Angle {
        return Angle(degrees: rhs.degrees * Double(lhs))
    }
}

#endif
