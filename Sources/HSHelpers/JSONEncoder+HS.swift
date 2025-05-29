//
//  File.swift
//  
//
//  Created by Rob Jonson on 20/07/2020.
//

import Foundation

public extension JSONEncoder {

    // Allows let encoder = JSONEncoder().pretty()
    func pretty() -> JSONEncoder {
        self.outputFormatting.insert(.prettyPrinted)
        self.outputFormatting.insert(.sortedKeys)
        if #available(iOS 13.0,macOS 10.15,tvOS 13.0, *) {
            // Unless we're embedding in html - this is better
            self.outputFormatting.insert(.withoutEscapingSlashes)
        } else {
            // Fallback on earlier versions
        }
        return self
    }

}
