//
//  UIViewController+HS.swift
//  Rhythm101
//
//  Created by Михаил Барашков on 05.06.2018.
//  Copyright © 2018 Tinkerswitch. All rights reserved.
//


#if !os(watchOS)
#if canImport(UIKit)

import Foundation
import UIKit

public protocol FromStoryboard: class {
    static var storyboardFilename:String {get}
    static var storyboardId:String {get}
    static func fromStoryboard() -> Self
}

public extension FromStoryboard where Self: UIViewController {
    
    
    /// Load VC from storyboard
    /// Storyboard ID is by default assumed to be the class name
    /// - Returns: the VC
    static func fromStoryboard() -> Self {
        let board = UIStoryboard.init(name: self.storyboardFilename, bundle: nil)
        
        guard let vc = board.instantiateViewController(withIdentifier: storyboardId) as? Self else {
            fatalError("Unable to instantiate storyboard with identifier: \(storyboardId)")
        }
        return vc
    }
    
    static var storyboardFilename:String {return String(describing: self)}
    static var storyboardId:String {return String(describing: self)}

}


#if !os(tvOS)
public extension UIViewController {
    func setModalAsFormOrFullscreen() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            modalPresentationStyle = .formSheet
        } else {
            modalPresentationStyle = .fullScreen
        }
    }
}
#endif


#endif
#endif
