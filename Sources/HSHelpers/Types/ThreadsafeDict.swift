//
//  ThreadsafeDictHolder.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 09/11/2018.
//

import Foundation

/// Threadsafe Dictionary using reader/writer pattern
/// Codeable/Decodable if the contained types are
public class ThreadsafeDict<Key: Hashable, Value> {

    private var dict: [Key: Value]
    private let queue: DispatchQueue = DispatchQueue(label: "com.hobbyistsoftware.threadsafe.dict",
                                                     qos: DispatchQoS.userInitiated,
                                                     attributes: .concurrent)

    /// Init
    /// - Parameter newDict: initial dictionary
    public init(_ newDict: [Key: Value]) {
        dict = newDict
    }

    /// if key/value are decodable, provide decodable initialiser
    required public init(from decoder: Decoder) throws
    where Key: Decodable, Value: Decodable {
        dict = try [Key: Value].init(from: decoder)
    }

    /// Returns regular dict
    public var unsafeContents: [Key: Value] {
        var result: [Key: Value]?
        queue.sync {
            result = dict
        }
        return result!
    }

    public subscript(index: Key) -> Value? {
        get {
            var result: Value?
            queue.sync {
                result = dict[index]
            }
            return result
        }
        set(newValue) {
            queue.async(flags: .barrier) {
                self.dict[index] = newValue
            }
        }
    }

    /// Remove Value
    /// - Parameter key: key
    public func removeValue(forKey key: Key) {
        queue.async(flags: .barrier) {
            self.dict.removeValue(forKey: key)
        }
    }

    /// Keys
    public var keys: Dictionary<Key, Value>.Keys {
        var result: Dictionary<Key, Value>.Keys?
        queue.sync {
            result = dict.keys
        }
        return result!
    }
}

extension ThreadsafeDict: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        try self.unsafeContents.encode(to: encoder)
    }
}

extension ThreadsafeDict: Decodable where Key: Decodable, Value: Decodable {

}
