//
//  Bundle+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 29/01/2019.
//  Copyright © 2019 HobbyistSoftware. All rights reserved.
//

import Foundation


/// Convenience accessors for Bundle
/// Bundle.main[.version]
public extension Bundle {
    
    /// Keys for common properties
    enum Key: String {
        case shortVersionString = "CFBundleShortVersionString",
        version = "CFBundleVersion",
        name =  "CFBundleName",
        displayName = "CFBundleDisplayName",
        id = "CFBundleIdentifier"
    }
    
    /// Allows Bundle.main[.version]
    subscript(index: Bundle.Key) ->  Any? {
        get {
            return self.object(forInfoDictionaryKey: index.rawValue)
        }
    }
    
    /// App Name
    var appName:String? {
        return (self[.displayName] as? String) ?? (self[.name] as? String)
    }
    
    /// "\(shortVersion) (\(build))"
    var appVersion:String? {
        if let shortVersion = self[.shortVersionString],
            let build = self[.version] {
            return "\(shortVersion) (\(build))"
        }
        return nil
    }
}
