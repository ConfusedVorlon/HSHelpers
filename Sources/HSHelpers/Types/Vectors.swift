//
//  CGPoint+HS.swift

//
//  Created by Rob Jonson on 28/06/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation
import CoreGraphics


/// Allows CGPoint, CGSize and CGVector to be approximately interchangable
/// You can do maths with mixed types
/// You can easily convert between them
public protocol Vector {
    var x: CGFloat {get set}
    var y: CGFloat {get set}
    var height: CGFloat {get set}
    var width: CGFloat {get set}
    var dx: CGFloat {get set}
    var dy: CGFloat {get set}
    
    init(x: CGFloat, y: CGFloat)
    init(_ vector:Vector)

    func floor <T: Vector>() -> T
    func length() -> CGFloat
}

//As long as each type has x & y, we can generate the others
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
    func floor <T: Vector>() -> T
    {
        return T(x: self.x.rounded(.down), y:self.y.rounded(.down))
    }
    
    func length() -> CGFloat
    {
        return sqrt(self.x * self.x + self.y * self.y)
    }
    
    var isPositive:Bool {
        return self.x > 0 && self.y > 0
    }
    
    init<T:FloatConvertible>(side : T) {
        self.init(x: side.cgFloat, y: side.cgFloat)
    }
}

//returns the smallest value in each dimension
public func maxEach<T: Vector>(_ left: T,_ right: Vector) -> T {
    let maxX = max(left.x, right.x)
    let maxY = max(left.y, right.y)
    
    return T(x: maxX, y: maxY)
}

//returns the largest value in each dimension
public func minEach<T: Vector>(_ left: T,_ right: Vector) -> T {
    let minX = min(left.x, right.x)
    let minY = min(left.y, right.y)
    
    return T(x: minX, y: minY)
}

//Operators return a value type matching the left item.
//This allows mixed maths with vector types, but does mean that order matters
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
    return T.init(x: left.x.truncatingRemainder(dividingBy: right.x) , y: left.y.truncatingRemainder(dividingBy: right.y) )
}

//See Number + PositiveModulus
public func %% <T: Vector>(left: T, right: Vector) -> T {
    return T.init(x: left.x %% right.x , y: left.y %% right.y )
}

public func + <T: Vector>(left: T, right: CGFloat) -> T {
    return T.init(x: left.x + right, y: left.y + right)
}

public func - <T: Vector>(left: T, right: CGFloat) -> T {
    return T.init(x: left.x - right, y: left.y - right)
}

public func * <T: Vector>(left: T, right: CGFloat) -> T {
    return T.init(x: left.x * right, y: left.y * right)
}

public func / <T: Vector>(left: T, right: CGFloat) -> T {
    return T.init(x: left.x / right, y: left.y / right)
}

public extension Vector {
    var cgPoint:CGPoint {
        CGPoint.init(x:x,y:y)
    }
    
    var cgSize:CGSize {
        CGSize.init(width:width,height: height)
    }
    
    var cgVector:CGVector {
        CGVector.init(dx:dx,dy: dy)
    }
}

extension CGSize: Vector {
    public init(_ vector:Vector){
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
    public init(_ vector:Vector){
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
    public init(_ vector:Vector){
        self.init(x: vector.x, y: vector.y)
    }

}



