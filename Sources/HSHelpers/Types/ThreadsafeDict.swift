//
//  ThreadsafeDictHolder.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 09/11/2018.
//

import Foundation

/// Only one writer at a time - but asynchronous (flags: .barrier)
/// Multiple readers at a time
/// All queue items run in the order they are enqueued - so all writes will complete before a read runs
public class ThreadsafeDict<Key:Hashable,Value>{
    
    private var dict:[Key:Value]
    private let queue:DispatchQueue
 
    public init(_ newDict:[Key:Value]) {
        dict = newDict
        
        queue = DispatchQueue(label: "com.hobbyistsoftware.threadsafe.dict",
                              qos: DispatchQoS.userInitiated,
                              attributes: .concurrent)
    }
    

    
    public var unsafeContents:[Key:Value] {
        get {
            var result:[Key:Value]?
            queue.sync {
                result = dict
            }
            return result!
        }
    }
    
    public subscript(index:Key) -> Value? {
        get {
            var result:Value?
            queue.sync {
                result = dict[index]
            }
            return result
        }
        set(newValue){
            queue.async(flags: .barrier) {
                self.dict[index] = newValue
            }
        }
    }
    
    public func removeValue(forKey key:Key) {
        queue.async(flags: .barrier) {
            self.dict.removeValue(forKey: key)
        }
    }
    
    public var keys: Dictionary<Key, Value>.Keys {
        get {
            var result:Dictionary<Key, Value>.Keys?
            queue.sync {
                result = dict.keys
            }
            return result!
        }
    }
}

extension ThreadsafeDict:Encodable where Key:Encodable,Value:Encodable {
    public func encode(to encoder: Encoder) throws {
        try self.unsafeContents.encode(to:encoder)
    }
}

//can't add decodable conformance because Swift won't have it
//https://forums.swift.org/t/can-i-really-not-add-decodeable-conformance-in-an-extension/50668
//extension ThreadsafeDict:Decodable where Key:Decodable,Value:Decodable {
//    public init(from decoder: Decoder) throws {
//        let dict = try Dictionary<Key,Value>.init(from: decoder)
//        self.init(dict)
//    }
//}
