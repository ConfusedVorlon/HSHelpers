//
//  URL+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 18/02/2019.
//

import Foundation

public extension URL {
    
//#if os(macOS)
    var bookmark:Data? { 
        do {
            return try self.bookmarkData(options: .withSecurityScope,
                                  includingResourceValuesForKeys: nil, relativeTo: nil)
        } catch (let error) {
            print("error making bookmark: \(error)")
            return nil
        }
    }
    
    init?(bookmark:Data?) {
        guard let bookmark = bookmark else {
            return nil
        }
        
        var bookmarkDataIsStale = false
        try? self.init(resolvingBookmarkData: bookmark,
                                           options: URL.BookmarkResolutionOptions.withSecurityScope,
                                           relativeTo: nil,
                                           bookmarkDataIsStale: &bookmarkDataIsStale)
        if bookmarkDataIsStale {
            return nil
        }
    }
    
    //from https://danieltull.co.uk/blog/2018/09/09/wrapping-urls-security-scoped-resource-methods/
    func accessSecurityScopedResource<Value>(_ accessor: (URL) throws -> Value) rethrows -> Value {
        
        let didStartAccessing = startAccessingSecurityScopedResource()
        
        defer {
            if didStartAccessing {
                stopAccessingSecurityScopedResource()
            }
        }
        
        return try accessor(self)
    }
    
//#endif
    


}
