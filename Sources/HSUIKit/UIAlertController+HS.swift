//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/10/2020.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UIAlertController {
    func present(from viewController: UIViewController,
                   barButtonItem:UIBarButtonItem,
                   permittedArrowDirections:UIPopoverArrowDirection = [],
                   completion: (() -> Void)? = nil){
        
        if preferredStyle == .actionSheet, let popoverController = popoverPresentationController {
            popoverController.barButtonItem = barButtonItem
            popoverController.permittedArrowDirections = permittedArrowDirections
        }

        viewController.present(self, animated: true,completion: completion)
    }
    
    func addAction(title:String,style:UIAlertAction.Style = .default,action:(()->Void)? = nil) {
        let action = UIAlertAction(title: title, style: style) {
            UIAlertAction in
            action?()
        }
        self.addAction(action)
    }
    
    
}

#endif
