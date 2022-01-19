//
//  CGPoint+HS.swift

//
//  Created by Rob Jonson on 28/06/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation
import CoreGraphics

// swiftlint:disable identifier_name

/// Allows CGPoint, CGSize and CGVector to be approximately interchangable
/// You can do maths with mixed types
/// You can easily convert between them
/// For example: CGPoint() + CGSize()
/// or CGSize() * 3
/// Extends accessors to apply to all types. So - cgPoint.width or cgSize.x are available
public protocol Vector {
    var x: CGFloat {get set}
    var y: CGFloat {get set}
    var height: CGFloat {get set}
    var width: CGFloat {get set}
    var dx: CGFloat {get set}
    var dy: CGFloat {get set}

    init(x: CGFloat, y: CGFloat)
    init(_ vector: Vector)

    func floor <T: Vector>() -> T
    var length: CGFloat {get}
}

// As long as each type has x & y, we can generate the others
extension Vector {
    public var width: CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }

    public var height: CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }

    public var dx: CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }

    public var dy: CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
}

public extension Vector {

    /// Round both components down to nearest int
    /// - Returns: Same type as input
    func floor <T: Vector>() -> T {
        return T(x: self.x.rounded(.down), y: self.y.rounded(.down))
    }

    var length: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }

    var isPositive: Bool {
        return self.x > 0 && self.y > 0
    }

    init<T: FloatConvertible>(side: T) {
        self.init(x: side.cgFloat, y: side.cgFloat)
    }
}

// returns the smallest value in each dimension
public func maxEach<T: Vector>(_ left: T, _ right: Vector) -> T {
    let maxX = max(left.x, right.x)
    let maxY = max(left.y, right.y)

    return T(x: maxX, y: maxY)
}

// returns the largest value in each dimension
public func minEach<T: Vector>(_ left: T, _ right: Vector) -> T {
    let minX = min(left.x, right.x)
    let minY = min(left.y, right.y)

    return T(x: minX, y: minY)
}

// Operators return a value type matching the left item.
// This allows mixed maths with vector types, but does mean that order matters
public func + <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x + right.x, y: left.y + right.y)
}

public func - <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x - right.x, y: left.y - right.y)
}

public func * <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x * right.x, y: left.y * right.y)
}

public func / <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x / right.x, y: left.y / right.y)
}

public func % <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x.truncatingRemainder(dividingBy: right.x), y: left.y.truncatingRemainder(dividingBy: right.y) )
}

/// Modulus - but always returns positive value
/// See Number + PositiveModulus
/// - Parameters:
///   - left: base
///   - right: modulo
/// - Returns: modulus (in both dimensions separately)
public func %% <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x %% right.x, y: left.y %% right.y )
}

/// (X,Y) + C
/// - Parameters:
///   - left: v
///   - right: const
/// - Returns: (X+C,Y+C)
public func + <T: Vector>(left: T, right: FloatConvertible) -> T {
    return T.init(x: left.x + right.cgFloat, y: left.y + right.cgFloat)
}

/// (X,Y) - C
/// - Parameters:
///   - left: v
///   - right: const
/// - Returns: (X-C,Y-C)
public func - <T: Vector>(left: T, right: FloatConvertible) -> T {
    return T.init(x: left.x - right.cgFloat, y: left.y - right.cgFloat)
}

/// (X,Y) * C
/// - Parameters:
///   - left: v
///   - right: const
/// - Returns: (X*C,Y*C)
public func * <T: Vector>(left: T, right: FloatConvertible) -> T {
    return T.init(x: left.x * right.cgFloat, y: left.y * right.cgFloat)
}

/// (X,Y) / C
/// - Parameters:
///   - left: v
///   - right: const
/// - Returns: (X/C,Y/C)
public func / <T: Vector>(left: T, right: FloatConvertible) -> T {
    return T.init(x: left.x / right.cgFloat, y: left.y / right.cgFloat)
}

public extension Vector {

    /// Cast to cgPoint
    var cgPoint: CGPoint {
        CGPoint.init(x: x, y: y)
    }

    /// Cast to cgSize
    var cgSize: CGSize {
        CGSize.init(width: width, height: height)
    }

    /// cast to cgVector
    var cgVector: CGVector {
        CGVector.init(dx: dx, dy: dy)
    }
}

extension CGSize: Vector {
    public init(_ vector: Vector) {
        self.init(x: vector.x, y: vector.y)
    }

    public var x: CGFloat {
        get {
            return self.width
        }
        set {
            self.width = newValue
        }
    }

    public var y: CGFloat {
        get {
            return self.height
        }
        set {
            self.height = newValue
        }
    }

    public init(x: CGFloat, y: CGFloat) {
        self.init(width: x, height: y)
    }
}

extension CGVector: Vector {
    public init(_ vector: Vector) {
        self.init(dx: vector.x, dy: vector.y)
    }

    public var x: CGFloat {
        get {
            return self.dx
        }
        set {
            self.dx = newValue
        }
    }

    public var y: CGFloat {
        get {
            return self.dy
        }
        set {
            self.dy = newValue
        }
    }

    public init(x: CGFloat, y: CGFloat) {
        self.init(dx: x, dy: y)
    }
}

extension CGPoint: Vector {
    public init(_ vector: Vector) {
        self.init(x: vector.x, y: vector.y)
    }

}
