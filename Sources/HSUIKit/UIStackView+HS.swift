//
//  UIStackView+HS.swift
//  ChillRemote
//
//  Created by Rob Jonson on 05/07/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//


#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit

@available(iOS 9.0, *)
public extension UIStackView {
    
    //https://stackoverflow.com/questions/41054308/swift-crash-on-removefromsuperview
    func removeArrangedViews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Creates a simple default horizontal stack
    ///
    /// - Returns: the stack
    class func horizontalStack() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.axis = .horizontal
        
        return stackView
    }
    
    /// Creates a simple default vertical stack
    ///
    /// - Returns: the stack
    class func verticalStack() -> UIStackView {
        let stackView = UIStackView.forAutoLayout()
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.axis = .vertical
        
        return stackView
    }
}


#endif
#endif
