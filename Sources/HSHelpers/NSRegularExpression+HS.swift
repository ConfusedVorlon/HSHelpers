//
//  NSRegularExpression+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 17/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension NSRegularExpression {

    func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        return self.matches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    func numberOfMatches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> Int {
        return self.numberOfMatches(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        return self.firstMatch(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

    func rangeOfFirstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSRange {
        return self.rangeOfFirstMatch(in: string, options: options, range: NSRange(location: 0, length: string.count))
    }

}
