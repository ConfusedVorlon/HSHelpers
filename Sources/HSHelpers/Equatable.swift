//
//  File.swift
//  
//
//  Created by Rob Jonson on 17/04/2023.
//

import Foundation

public extension Equatable {
    func isIn(_ array:[Self]) -> Bool {
        return array.contains(self)
    }
}
