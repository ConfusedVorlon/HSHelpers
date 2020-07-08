//
//  PresentedNSViewController.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 21/03/2019.
//

#if canImport(AppKit)

import Cocoa

class PresentedNSViewController: NSViewController {
    var presented:(()->Void)?
    var dismissed:(()->Void)?
    
    func presentAsSheet(from:NSViewController, presented:(()->Void)? = nil,dismissed:(()->Void)? = nil ) {
        self.presented = presented
        self.dismissed = dismissed
        
        from.presentAsSheet(self)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        presented?()
        presented = nil
    }

    override func viewDidDisappear() {
        super.viewDidDisappear()
        dismissed?()
        dismissed = nil
    }
    
}

#endif
