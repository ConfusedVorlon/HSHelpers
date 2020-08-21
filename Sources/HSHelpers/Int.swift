//
//  Int.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 13/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation

extension Int {
    
    //4.times{print("hello")}
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }

    //allows 4.times(print("hello")) instead of 4.times{print("hello")}
    func times(_ f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

