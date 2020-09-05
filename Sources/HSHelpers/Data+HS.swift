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
    
    @available(OSX 10.11, *)
    func writeWithIntermediaryDirectories(to url: URL, options: Data.WritingOptions = []) throws {
        if !url.isFileURL {
            fatalError("writeWithIntermediaryDirectories is for FileURLs")
        }
        
        let dir = url.directory
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        
        try self.write(to: url)
    }
}
