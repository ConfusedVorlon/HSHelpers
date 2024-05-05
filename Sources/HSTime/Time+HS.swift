//
//  TimeInterval+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 17/06/2019.
//  Copyright © 2019 HobbyistSoftware. All rights reserved.
//

import Foundation

//https://github.com/dreymonde/Time
import Time

public extension Interval {

    
    /// Allows 2.days.after(someDate)
    /// - Parameter date: base
    /// - Returns: new date
    func after(_ date:Date) -> Date{
        return date + self
    }
    
    // Allows 2.days.fromNow
    var fromNow: Date {
        return Date.init() + self
    }
    
    /// Allows 2.days.before(someDate)
    /// - Parameter date: base
    /// - Returns: new date
    func before(_ date:Date) -> Date{
        return date - self
    }

    // Allows 1.hour.ago
    var ago: Date {
        return Date.init() - self
    }

}
