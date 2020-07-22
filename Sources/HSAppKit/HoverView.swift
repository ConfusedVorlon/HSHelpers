//
//  HoverView.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 30/11/2018.
//




#if os(macOS)

import AppKit

open class HoverView: NSView {

    open var hovering: Bool = false {
        didSet {
            if oldValue != hovering {
                hoverChangeBlock?(hovering)
            }
        }
    }
    
    open var hoverChangeBlock:((Bool)->Void)?

    open override func updateTrackingAreas() {
 
        for trackingArea in self.trackingAreas {
            self.removeTrackingArea(trackingArea)
        }
        
        let options: NSTrackingArea.Options = [.mouseEnteredAndExited, .activeAlways]
        let trackingArea = NSTrackingArea(rect: self.bounds, options: options, owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
        super.updateTrackingAreas()
    }
    
    open override func mouseEntered(with theEvent: NSEvent) {
        hovering = true
    }
    
    open override func mouseExited(with theEvent: NSEvent) {
        hovering = false
    }
    
}


#endif
