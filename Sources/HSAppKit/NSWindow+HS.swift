//  Converted to Swift 4 by Swiftify v4.2.29618 - https://objectivec2swift.com/
//
//  NSView+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 14/11/2018.
//

#if os(macOS)

import AppKit
import HSHelpers

public extension NSWindow {
    var isFullscreen: Bool {
        return self.styleMask.contains(.fullScreen)
    }

    var isCloseable: Bool {
        return self.styleMask.contains(.closable)
    }

    func ensureWindowIsFullyVisible() {
        // swiftlint:disable shorthand_operator

        if let windowScreen = NSScreen.screens.first(where: { $0.frame.contains(self.frame.center) }) {
            let windowFrame = windowScreen.frame

            // move edges in order
            var newFrame = self.frame

            // right
            if newFrame.maxX > windowFrame.maxX {
                newFrame.center = newFrame.center + CGPoint(x: windowFrame.maxX - newFrame.maxX, y: 0)
            }

            // left
            if newFrame.minX < windowFrame.minX {
                newFrame.center = newFrame.center + CGPoint(x: windowFrame.minX - newFrame.minX, y: 0)
            }

            // bottom
            if newFrame.maxY > windowFrame.maxY {
                newFrame.center = newFrame.center + CGPoint(x: 0, y: windowFrame.maxY - newFrame.maxY)
            }

            // left
            if newFrame.minY < windowFrame.minY {
                newFrame.center = newFrame.center + CGPoint(x: 0, y: windowFrame.minY - newFrame.minY)
            }

            self.setFrameOrigin(newFrame.origin)
        }
    }
}

#endif
