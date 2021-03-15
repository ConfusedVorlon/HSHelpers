//
//  WKWebView+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 21/05/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

#if !os(watchOS) && !os(tvOS)

import Foundation
import WebKit

public extension WKWebView {
    
    
    /// Load an address
    ///
    /// - Parameter address: web address
    func load(address:String){
        if let myURL = URL(string: address) {
            self.load(url:myURL)
        }
    }
    
    /// Load a url
    ///
    /// - Parameter address: web url
    func load(url:URL){
        let myRequest = URLRequest(url: url)
        self.load(myRequest)
    }
}

#endif
