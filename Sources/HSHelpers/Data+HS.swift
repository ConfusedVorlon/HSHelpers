//
//  NSData.swift
//  ChillRemote
//
//  Created by Rob Jonson on 16/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//


import Foundation

public extension Data {
    
// Use URL directly
//    init(contentsOfFile path:String) throws {
//        let url = URL.init(fileURLWithPath: path)
//        try self.init(contentsOf: url)
//    }
    
    var utf8String:String? {
        return String(data: self, encoding: .utf8)
    }
    
    var utf16String:String? {
        return String(data: self, encoding: .utf16)
    }
}
