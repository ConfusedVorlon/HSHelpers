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

