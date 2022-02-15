//
//  Int.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 13/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension Int {

    // 4.times{print("hello")}
    @discardableResult
    /// Call the block multiple times
    /// - Returns: array containing result of calls
    func times<V>(_ block: () -> V) -> [V] {
        var result:[V] = []
        if self > 0 {
            
            for _ in 0..<self {
                result.append(block())
            }
        }
        return result
    }

    // allows 4.times(print("hello")) instead of 4.times{print("hello")}
    @discardableResult
    func times<V>(_ block: @autoclosure () -> V) -> [V] {
        return self.times {block()}
    }
}
