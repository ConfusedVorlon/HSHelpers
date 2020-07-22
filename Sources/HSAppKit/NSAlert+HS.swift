//
//  NSAlert+HS.swift
//  
//
//  Created by Rob Jonson on 03/07/2019.
//

#if os(macOS)

import Foundation
import AppKit

public extension NSAlert {
    
    class func alert(from window:NSWindow, message:String,
                     informativeText:String? = nil,
                     ok:String = "Ok",
                     cancel:String? = nil,
                     okBlock:(()->())? = nil) {
        let alert = NSAlert()
        
        alert.messageText = message
        if let informativeText = informativeText {
            alert.informativeText = informativeText
        }
        
        alert.addButton(withTitle: ok)
        if let cancel = cancel {
            alert.addButton(withTitle: cancel)
        }
        
        alert.beginSheetModal(for: window, completionHandler: { returnCode in
            if returnCode == .alertFirstButtonReturn {
                okBlock?()
            }
        })
    }
}

#endif
