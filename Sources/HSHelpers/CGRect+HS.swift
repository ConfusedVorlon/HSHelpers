//
//  CGRect+HS.swift

//
//  Created by Rob Jonson on 19/08/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension CGRect {
    init(width: Int = 0, height: Int = 0) {
        self.init(x:0,y:0,width:width,height:height)
    }
    
    init(width: Double = 0, height: Double = 0) {
        self.init(x:0,y:0,width:width,height:height)
    }
    
    init(width: CGFloat = 0, height: CGFloat = 0) {
        self.init(x:0,y:0,width:width,height:height)
    }
    
    static func * (left: CGRect, right: CGFloat) -> CGRect {
        return CGRect.init(x: left.origin.x * right,
                           y: left.origin.y * right,
                           width: left.size.width * right,
                           height: left.size.height * right)
    }
    
    static func * (left: CGRect, right: Vector) -> CGRect {
        return CGRect.init(x: left.origin.x * right.x,
                           y: left.origin.y * right.y,
                           width: left.size.width * right.x,
                           height: left.size.height * right.y)
    }
    
    var center:NSPoint {
        get {
            return NSPoint.init(x: NSMidX(self), y: NSMidY(self))
        }
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
    }
    
    func scaledOnCenter(by scale:CGFloat) -> NSRect {
        let initialCenter = center
        
        var newRect = self
        let newSize = self.size * scale
        
        newRect.size = newSize
        newRect.center = initialCenter
        
        return newRect
    }
    
    var isPositive:Bool {
        return self.size.isPositive
    }
}

public extension Array where Element == CGRect {
    
    /// Bounding rect containing all the rectangles in the array
    var boundingRect:CGRect {
        guard self.count > 0 else {
            return .zero
        }
        
        let firstResult = self.first!
        let union = self.reduce(into: firstResult) { (result, rect) in
            result = NSUnionRect(result, rect)
        }
        
        return union
    }
}
