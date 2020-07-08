//
//  NSGraphicsContext+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 21/03/2019.
//

#if canImport(AppKit)

import Foundation
import AppKit

public extension NSGraphicsContext {
    class func protectContext(_ block:(CGContext)->Void) {
        guard let context = NSGraphicsContext.current?.cgContext else {
            return
        }

        context.saveGState()

        block(context)

        context.restoreGState()

    }
}

#endif
