//
//  NSRegularExpression+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 17/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

extension NSRegularExpression {

    open func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        return self.matches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    open func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> Int {
        return self.numberOfMatches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    open func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        return self.firstMatch(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    open func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSRange {
        return self.rangeOfFirstMatch(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

}
