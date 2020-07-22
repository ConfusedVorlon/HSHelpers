//
//  NSView+NibLoadable.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 03/12/2018.
//


#if os(macOS)

import Foundation
import AppKit

public protocol NibLoadable {
    static var nibName: String? { get }
    static func createFromNib(in bundle: Bundle) -> Self?
}

public extension NibLoadable where Self: NSView {
    
    static var nibName: String? {
        return String(describing: Self.self)
    }
    
    static func createFromNib(in bundle: Bundle = Bundle.main) -> Self? {
        guard let nibName = nibName else { return nil }
        var topLevelArray: NSArray? = nil
        bundle.loadNibNamed(NSNib.Name(nibName), owner: self, topLevelObjects: &topLevelArray)
        guard let results = topLevelArray else { return nil }
        let views = Array<Any>(results).filter { $0 is Self }
        return views.last as? Self
    }
}

#endif
