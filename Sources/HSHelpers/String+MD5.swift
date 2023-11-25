//
//  File.swift
//  
//
//  Created by Rob Jonson on 18/09/2022.
//

import Foundation

#if canImport(CryptoKit)
import CryptoKit


@available(iOS 13.0,macOS 10.15,tvOS 13.0, *)
public extension String {
    
    /// Returns md5 String
    var md5String: String {
        let data = Data(string.utf8)
        return data.md5String
    }
}


#endif
