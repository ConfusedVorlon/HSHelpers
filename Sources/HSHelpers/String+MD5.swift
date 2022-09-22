//
//  File.swift
//  
//
//  Created by Rob Jonson on 18/09/2022.
//

import Foundation

#if canImport(CryptoKit)
import CryptoKit


@available(iOS 13.0, *)
public extension String {
    
    var md5: String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}


#endif
