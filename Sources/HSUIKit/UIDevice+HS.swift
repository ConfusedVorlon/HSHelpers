//
//  UIDevice+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 16/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//


#if canImport(UIKit) && !os(watchOS)


import Foundation
import UIKit

public extension UIDevice {
    
    static var isIpad:Bool = {
        return UIDevice.current.userInterfaceIdiom == .pad
    }()
    
    @available(*, deprecated, message: "Use Build.isDebug")
    static let isDebug: Bool = {
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
    
    @available(*, deprecated, message: "Use Bundle.main.appName")
    class func appName() -> String? {
        var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        if name == nil {
            name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        }
        return name
    }
    
    @available(*, deprecated, message: "Use Bundle.main.appVersion")
    class func appVersion() -> String? {
        if let shortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString"),
            let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
            return "\(shortVersion) (\(build))"
        }
        return nil
    }
    
    @available(*, deprecated, message: "Use HSLogging.appInfo")
    class func appInfo(helperInfo: [String : String] = [:]) -> String {
        var appName = Bundle.main.object(forInfoDictionaryKey: "FeedbackName") as? String
        if appName == nil {
            appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        }
        if appName == nil {
            appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        }
        var mainInfo:[String:String] = [
            "App" : appName ?? "",
            "Version" : Bundle.main.appVersion ?? "",
            "Device" : UIDevice.current.model,
            "iOS Version" : UIDevice.current.systemVersion,
            "Feedback date" : Date().fixedShortDateTimeString
        ]
        
        mainInfo = mainInfo.merging(helperInfo) { $1 }
        
        var info = "----App info. Please leave----\n"
        for key: String in mainInfo.keys {
            if let aKey = mainInfo[key] {
                info += "\(key) : \(aKey)\n"
            }
        }

        info += "-------------------------------------"
        return info
    }

    
}

#endif
