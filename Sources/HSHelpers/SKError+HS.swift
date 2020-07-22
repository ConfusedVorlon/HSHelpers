//
//  StoreKit+HS.swift
//  Icns Builder
//
//  Created by Rob Jonson on 12/02/2019.
//  Copyright © 2019 Rob Jonson. All rights reserved.
//

import Foundation
import StoreKit

#if !os(watchOS)
public extension SKError {
    var helpfulMessage:String {
        var errorMessage = "Unknown Error"
        switch self.code {
        case .unknown: errorMessage = (self as NSError).localizedDescription
        case .clientInvalid:  errorMessage = "Not allowed to make the payment"
        case .paymentCancelled: errorMessage = "The transaction was cancelled"
        case .paymentInvalid:  errorMessage = "The purchase identifier was invalid"
        case .paymentNotAllowed:  errorMessage = "The device is not allowed to make the payment"
        case .storeProductNotAvailable:  errorMessage = "The product is not available in the current storefront"
        case .cloudServicePermissionDenied:  errorMessage = "Access to cloud service information is not allowed"
        case .cloudServiceNetworkConnectionFailed:  errorMessage = "Could not connect to the network"
        case .cloudServiceRevoked:  errorMessage = "User has revoked permission to use this cloud service"
        default:  errorMessage = (self as NSError).localizedDescription
        }
        return errorMessage
    }
}
#endif


