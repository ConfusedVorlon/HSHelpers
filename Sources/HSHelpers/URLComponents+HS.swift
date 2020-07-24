//
//  URLComponents+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 03/12/2018.
//

import Foundation


public extension Array where Element == URLQueryItem {
    @available(*, deprecated,message: "Use subscript directly on URLComponents")
    subscript(index:String) -> String? {
        
        for item in self {
            if item.name == index {
                return item.value
            }
        }
        
        return nil
    }
}

public extension URLComponents {
    
    //Allows myURLComponent["myParam"] = "newValue"
    subscript(index:String) -> String? {
        
        get {
            let items = self.queryItems ?? []
            
            for item in items {
                if item.name == index {
                    return item.value
                }
            }
            
            return nil
        }
        set {
            var items = self.queryItems ?? []
            
            items = items.filter{$0.name != index}
            
            if let newValue = newValue {
                items.append(URLQueryItem.init(name: index, value: newValue))
            }
            
            if items.count == 0 {
                queryItems = nil
            }
            else {
                queryItems = items
            }
        }
    }
    
    init(scheme:String = "http",host:String,port:Int?,path:String?) {
        self.init()
        self.scheme = scheme
        self.host = host
        self.port = port
        
        
        guard var path = path, path.count > 0 else {
            //empty string or nil
            return
        }

        if  !path.hasPrefix("/") {
            path = "/"+path
            
        }
        
        self.path = path
    }
    
    //https://stackoverflow.com/questions/43052657/encode-using-urlcomponents-in-swift
    mutating func encodePlusses() {
        self.percentEncodedQuery = self.percentEncodedQuery?
        .replacingOccurrences(of: "+", with: "%2B")
    }
    
    mutating func treatUnencodedPlussesAsSpaces() {
        self.percentEncodedQuery = self.percentEncodedQuery?
        .replacingOccurrences(of: "+", with: "%20")
    }
}
