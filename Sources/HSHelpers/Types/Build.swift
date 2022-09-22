//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/07/2020.
//

import Foundation

public struct Build {

    /// Returns if current build is built for debug.
    /// Uses assert to determine this without need for compilation flags
    public static let isDebug: Bool = {
        var isDebug = false
        // function with a side effect and Bool return value that we can pass into assert()
        func set(debug: Bool) -> Bool {
            isDebug = debug
            return isDebug
        }
        // assert:
        // "Condition is only evaluated in playgrounds and -Onone builds."
        // so isDebug is never changed to true in Release builds
        assert(set(debug: true))
        return isDebug
    }()
    
    public static let isPreview: Bool = {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }()
}
