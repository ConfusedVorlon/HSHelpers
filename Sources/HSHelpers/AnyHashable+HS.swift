//
//  TypeConversions.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 13/11/2018.
//

import Foundation

extension AnyHashable {
    var string:String? {
        return self as? String
    }

    var int:Int? {
        return self as? Int
    }
}

