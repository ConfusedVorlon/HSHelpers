//
//  NSButton+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 25/01/2019.
//


#if os(macOS)

import Foundation
import AppKit
import HSHelpers

public extension NSButton {
    var isOn:Bool {
        get {
            return self.state == .on
        }
        set {
            self.state = newValue ? .on : .off
        }
    }
    
    func setTitle(colour:NSColor){
        let fullText = self.attributedTitle.mutable
        fullText.updateAttributes([NSAttributedString.Key.foregroundColor:colour])
        self.attributedTitle = fullText
    }
}

#endif
