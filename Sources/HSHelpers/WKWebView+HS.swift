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
        let myURL = URL(string: address)
        let myRequest = URLRequest(url: myURL!)
        self.load(myRequest)
    }
}

#endif
