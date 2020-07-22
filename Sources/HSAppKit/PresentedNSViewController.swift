//
//  PresentedNSViewController.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 21/03/2019.
//


#if os(macOS)

import AppKit

open class PresentedNSViewController: NSViewController {
    private var presented:(()->Void)?
    private var dismissed:(()->Void)?
    
    open func presentAsSheet(from:NSViewController, presented:(()->Void)? = nil,dismissed:(()->Void)? = nil ) {
        self.presented = presented
        self.dismissed = dismissed
        
        from.presentAsSheet(self)
    }
    
    open override func viewDidAppear() {
        super.viewDidAppear()
        presented?()
        presented = nil
    }

    open override func viewDidDisappear() {
        super.viewDidDisappear()
        dismissed?()
        dismissed = nil
    }
    
}

#endif
