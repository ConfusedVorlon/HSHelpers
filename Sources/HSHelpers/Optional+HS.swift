//
//  Optionals+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 27/11/2018.
//

import Foundation

public extension Optional {
    var isNil: Bool {
        return self == nil
    }

    var isPresent: Bool {
        return self != nil
    }

    var isNotNil: Bool {
        return self != nil
    }

}

public extension Optional where Wrapped == String {
    var isPresent: Bool {
        if self == nil || self == "" {
            return false
        }
        return true
    }

    var isNilOrBlank: Bool {
        return !isPresent
    }
}

public extension Optional where Wrapped == Bool {
    var isTrue: Bool {
        if self == true {
            return true
        }

        return false
    }

    var isNilOrFalse: Bool {
        return !isTrue
    }
}

public extension Optional where Wrapped == Data {

    var isNilOrEmpty: Bool {
        return self.isNil || self!.count == 0
    }
}
