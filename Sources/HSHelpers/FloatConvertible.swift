//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/07/2020.
//

import Foundation
import CoreGraphics

// From https://gist.github.com/erica/efc9f1df7a43350cc31b
public protocol FloatConvertible {
    var double: Double { get }
    var float: Float { get }
    var int: Int { get }
    var cgFloat: CGFloat { get }
}

public extension FloatConvertible {
    var float: Float {get {return Float(double)}}
    var int: Int {get {return lrint(floor(double))}}
    var cgFloat: CGFloat {
        return CGFloat(double)
    }
}

extension CGFloat: FloatConvertible {public var double: Double {return Double(self)}}
extension Float: FloatConvertible {public var double: Double {return Double(self)}}
extension Double: FloatConvertible {public var double: Double {return self}}
extension Int: FloatConvertible {public var double: Double {return Double(self)}}
