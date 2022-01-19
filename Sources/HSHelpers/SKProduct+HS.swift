//
//  SKStoreKit+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 13/08/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import StoreKit

@available(watchOS 6.2, *)
public extension SKProduct {

    @available(OSX 10.13.2, iOS 11.2, tvOS 11.2, watchOS 6.2, *)
    var subscriptionPricingDescription: String? {
        guard let  subscriptionPeriod = self.subscriptionPeriod,
            let localizedPrice = self.localizedPrice else {
                return nil
        }

        let priceString = "\(localizedPrice) per \(subscriptionPeriod.unit.description)"

        return priceString
    }

    // Clashes with SwiftyStoreKit, so keep it private
    private var localizedPrice: String? {
        return priceFormatter(locale: priceLocale).string(from: price)
    }

    private func priceFormatter(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter
    }

    @available(OSX 10.13.2, iOS 11.2, tvOS 11.2, *)
    var freeTrialPeriod: String? {

        guard let introductoryPrice = introductoryPrice else {
            return nil
        }
        if introductoryPrice.paymentMode != .freeTrial {
            return nil
        }

        let trialPeriod = introductoryPrice.subscriptionPeriod

        var description = "\(trialPeriod.numberOfUnits) \(trialPeriod.unit.description)"
        if trialPeriod.numberOfUnits > 1 {
            description += "s"
        }

        return description
    }

}

@available(OSX 10.13.2, iOS 11.2, tvOS 11.2, watchOS 6.2, *)
extension SKProduct.PeriodUnit {
    var description: String {
        switch self {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "Year"
        @unknown default:
            assert(false, "Unexpected SKProduct Unit")
            return "??"
        }
    }
}
