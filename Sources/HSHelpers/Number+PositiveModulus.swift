//
//  PositiveRemainder+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 03/06/2020.
//

import Foundation
import CoreGraphics

infix operator %%

public extension Float {

    /// Returns modulus, but forces it to be positive
    /// - Parameters:
    ///   - left: number
    ///   - right: modulus
    /// - Returns: positive modulus
    static  func %% (_ left: Float, _ right: Float) -> Float {
        let truncatingRemainder = left.truncatingRemainder(dividingBy: right)
        return truncatingRemainder >= 0 ? truncatingRemainder : truncatingRemainder+abs(right)
    }
}

public extension Double {

    /// Returns modulus, but forces it to be positive
    /// - Parameters:
    ///   - left: number
    ///   - right: modulus
    /// - Returns: positive modulus
    static  func %% (_ left: Double, _ right: Double) -> Double {
        let truncatingRemainder = left.truncatingRemainder(dividingBy: right)
        return truncatingRemainder >= 0 ? truncatingRemainder : truncatingRemainder+abs(right)
    }
}

public extension CGFloat {
    /// Returns modulus, but forces it to be positive
    /// - Parameters:
    ///   - left: number
    ///   - right: modulus
    /// - Returns: positive modulus
    static  func %% (_ left: CGFloat, _ right: CGFloat) -> CGFloat {
        let truncatingRemainder = left.truncatingRemainder(dividingBy: right)
        return truncatingRemainder >= 0 ? truncatingRemainder : truncatingRemainder+abs(right)
    }
}

public extension Int {
    /// Returns modulus, but forces it to be positive
    /// - Parameters:
    ///   - left: number
    ///   - right: modulus
    /// - Returns: positive modulus
    static  func %% (_ left: Int, _ right: Int) -> Int {
        let truncatingRemainder = left % right
        return truncatingRemainder >= 0 ? truncatingRemainder : truncatingRemainder+abs(right)
    }
}
