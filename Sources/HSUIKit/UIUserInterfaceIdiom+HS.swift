//
//  File.swift
//  
//
//  Created by Rob Jonson on 24/07/2020.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UIUserInterfaceIdiom {
    var description: String {
        switch self {

        case .unspecified:
            return "device"
        case .phone:
            return "iPhone"
        case .pad:
            return "iPad"
        case .tv:
            return "Apple TV"
        case .carPlay:
            return "car"
        @unknown default:
            assert(false, "Unknown Device")
            return "device"
        }
    }
}

#endif
