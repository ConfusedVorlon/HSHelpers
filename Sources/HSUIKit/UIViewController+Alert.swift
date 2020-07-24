//
//  UIViewController+Alert.swift
//  VLCStreamer2
//
//  Created by Rob Jonson on 09/09/2019.
//


#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit

public extension UIViewController {

    func showAlert(title:String?,message:String?,cancelButton:String = "Cancel") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelButton, style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
}

#endif
#endif
