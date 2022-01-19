//
//  NSViewController+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 27/11/2018.
//

#if os(macOS)

import Foundation
import AppKit

public protocol FromStoryboard: class {
    static var storyboardFilename: String {get}
    static var storyboardId: String? {get}
    static func fromStoryboard() -> Self
    func dismissSheet()
}

public extension FromStoryboard where Self: NSViewController {

    /// Load VC from storyboard
    /// NB: VC must be the Initial View Controller in the storyboard
    /// - Returns: the VC
    static func fromStoryboard() -> Self {

        let board = NSStoryboard.init(name: self.storyboardFilename, bundle: nil)

        if let storyboardId = storyboardId {
            guard let vc = board.instantiateController(withIdentifier: storyboardId) as? Self else {
                fatalError("Unable to instantiate storyboard with identifier: \(storyboardId)")
            }
            return vc
        } else {
            guard let vc = board.instantiateInitialController() as? Self else {
                fatalError("Initial Controller not set in storyboard \(self.storyboardFilename)")
            }
            return vc
        }

    }

    static var storyboardFilename: String {return String(describing: self)}
    static var storyboardId: String? {return nil}
}

public extension NSViewController {
    func dismissSheet() {
        self.presentingViewController?.dismiss(self)
    }
}

#endif
