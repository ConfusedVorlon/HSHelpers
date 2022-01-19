//
//  String+HS.swift

//
//  Created by Rob Jonson on 10/07/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

public func NSLocalizedString(_ string: String) -> String {
    return NSLocalizedString(string, comment: string)
}

public extension LosslessStringConvertible {
    var string: String {
        return String(self)
    }
}

//https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language/38215613#38215613
public extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>) -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}

public extension String {

    // MARK: Type management

    init?(ifString object: Any?) {
        if let aString = object as? String {
            self = aString
        } else {
            return nil
        }
    }

    func nilIfEmpty() -> String? {
        return self.isEmpty ? nil : self
    }

    // MARK: Parts

    func deleting(prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func deleting(suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }

    func contains(string: String) -> Bool {
        return self.range(of: string) != nil
    }

    func occurences(of search: String) -> Int {
        guard search.count > 0 else {
            preconditionFailure()
        }

        let shrunk = self.replacingOccurrences(of: search, with: "")

        return (self.count - shrunk.count)/search.count
    }

    mutating func truncate(to length: Int, trailing: String? = "...") {
        if self.count > length {
            let index = self.index(self.startIndex, offsetBy: length)
            self = self[..<index] + (trailing ?? "")
        }
    }

    // MARK: Range

    func fullRange() -> NSRange {
        return NSRange(location: 0, length: self.count)
    }

    /// Returns a random alphanumeric string of length
    /// - Parameter length: length
    /// - Returns: string
    static func random(length: Int) -> String {

        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }

    // MARK: Numerics

    var isInteger: Bool {
        let intValue = Int(self) ?? 0
        let backToString = String(intValue)
        return (backToString == self)
    }

    // Note "1.2" returns nil
    var int: Int? {
        return Int(self)
    }

    var float: Float? {
        return Float(self)
    }

    // MARK: Base 64

    func toBase64() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }

    func fromBase64() -> String? {
        guard let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }

}
