//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/03/2023.
//

import Foundation

#if canImport(CryptoKit)
import CryptoKit

public extension Data {
    @available(macOS 10.15, *)
    /// Returns md5 as Data
    var md5Data:Data {
        Data(Insecure.MD5.hash(data: self))
    }

    @available(macOS 10.15, *)
    /// Returns md5 as String
    var md5String:String {
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }
}
#endif
