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
public class ThreadsafeArray<Value>{
    
    private var array:[Value]
    private let queue = DispatchQueue(label: "com.hobbyistsoftware.threadsafe.array",
                                      qos: DispatchQoS.userInitiated,
                                      attributes: .concurrent)
    
    public init(_ newArray:[Value]) {
        array = newArray
    }
    
    //if value is decodable, provide decodable initialiser
    required public init(from decoder: Decoder) throws
      where Value: Decodable
    {
        array = try Array<Value>.init(from: decoder)
    }
    
    public var unsafeContents:[Value] {
        get {
            var result:[Value]?
            queue.sync {
                result = array
            }
            return result!
        }
    }
    
    public subscript(index:Int) -> Value? {
        get {
            var result:Value?
            queue.sync {
                result = array[index]
            }
            return result
        }
        set(newValue){
            queue.async(flags: .barrier) {
                self.array[index] = newValue!
            }
        }
    }
    
    public func append(_ newValue:Value){
        queue.async(flags: .barrier) {
            self.array.append(newValue)
        }
    }
    
}

extension ThreadsafeArray:Encodable where Value:Encodable {
    public func encode(to encoder: Encoder) throws {
        try self.unsafeContents.encode(to:encoder)
    }
}

extension ThreadsafeArray:Decodable where Value:Decodable {

}
