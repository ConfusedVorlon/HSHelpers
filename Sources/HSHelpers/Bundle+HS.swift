//
//  Bundle+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 29/01/2019.
//  Copyright © 2019 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension Bundle {

    enum Key: String {
        case shortVersionString = "CFBundleShortVersionString",
        version = "CFBundleVersion",
        name =  "CFBundleName",
        displayName = "CFBundleDisplayName"
    }

    /// Allows Bundle.main[.version]
    subscript(index: Bundle.Key) ->  Any? {
        return self.object(forInfoDictionaryKey: index.rawValue)
    }

    var appName: String? {
        return (self[.displayName] as? String) ?? (self[.name] as? String)
    }

    var appVersion: String? {
        if let shortVersion = self[.shortVersionString],
            let build = self[.version] {
            return "\(shortVersion) (\(build))"
        }
        return nil
    }
}
