//
//  NSDocument+SaveCompletion.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 11/05/2020.
//

#if os(macOS)

import Foundation
import AppKit

public typealias NSDocSaveCompletion = (Bool, UnsafeMutableRawPointer?) -> Void

private class SaveCompletionHolder: NSObject {
    var completion: NSDocSaveCompletion

    @objc
    func document(_ doc: NSDocument?, didSave: Bool, contextInfo: UnsafeMutableRawPointer?) {
        completion(didSave, contextInfo)
        doc?.saveCompletionHolder = nil
    }

    init(completion newCompletion:@escaping NSDocSaveCompletion) {
        completion = newCompletion
        super.init()
    }
}

private var NSDocSaveCompletionAssociatedObjectHandle: UInt8 = 0

public extension NSDocument {
    func save(contextInfo: UnsafeMutableRawPointer? = nil, completion:@escaping NSDocSaveCompletion) {
        let holder = SaveCompletionHolder.init(completion: completion)
        self.saveCompletionHolder = holder
        self.save(withDelegate: holder,
                  didSave: #selector(SaveCompletionHolder.document(_:didSave:contextInfo:)),
                  contextInfo: contextInfo)
    }

    fileprivate var saveCompletionHolder: SaveCompletionHolder? {
        get {
            return objc_getAssociatedObject(self, &NSDocSaveCompletionAssociatedObjectHandle) as? SaveCompletionHolder
        }
        set {
            objc_setAssociatedObject(self, &NSDocSaveCompletionAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

#endif
