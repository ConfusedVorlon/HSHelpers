//
//  File.swift
//  
//
//  Created by Rob Jonson on 20/07/2020.
//

import Foundation

public extension JSONEncoder {

    //Allows let encoder = JSONEncoder().pretty()
    func pretty() -> JSONEncoder {
        self.outputFormatting.insert(.prettyPrinted)
        return self
    }

}
