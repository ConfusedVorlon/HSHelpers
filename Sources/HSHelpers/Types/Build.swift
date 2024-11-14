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
    
    public static let isMacOS:Bool = {
#if os(macOS)
        return true
#else
        return false
#endif
    }()
    
    public static let isPreview: Bool = {
        //Belt and braces
        if !Build.isDebug {
            return false
        }

        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }()
    
    public static let isUnitTesting: Bool = {
        //Belt and braces
        if !Build.isDebug {
            return false
        }
        
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }()
    
    public static let isBeingProfiled: Bool = {
        let xpcServiceName =  ProcessInfo.processInfo.environment["XPC_SERVICE_NAME"]
        return xpcServiceName?.starts(with: "application.com.apple.dt.Instruments") == true
    }()
}
