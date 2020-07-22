//
//  CGImageSource+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 29/06/2020.
//

import Foundation
import CoreImage

public extension CGImageSource {
    
    /// Rough and ready test for dynamic images
    var isDynamic:Bool {
        guard let uti:String = (CGImageSourceGetType(self) as String?) else {
            return false
        }

        if uti == "public.heic" {
            let partCount = CGImageSourceGetCount(self)
            if partCount >= 8 {
                return true
            }
        }
        
        return false
    }
}
