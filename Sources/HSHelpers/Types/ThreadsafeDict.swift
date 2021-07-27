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
    private let queue:DispatchQueue = DispatchQueue(label: "com.hobbyistsoftware.threadsafe.dict",
                                                   qos: DispatchQoS.userInitiated,
                                                   attributes: .concurrent)
 
    public init(_ newDict:[Key:Value]) {
        dict = newDict
    }
    
    //if key/value are decodable, provide decodable initialiser
    required public init(from decoder: Decoder) throws
      where Key: Decodable, Value: Decodable
    {
      dict = try Dictionary<Key,Value>.init(from: decoder)
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

extension ThreadsafeDict:Decodable where Key:Decodable,Value:Decodable {

}
