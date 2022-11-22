//
//  UIViewController+Safari.swift
//  Off
//
//  Created by Rob Jonson on 28/03/2020.
//

#if !os(watchOS) && !os(tvOS) && canImport(UIKit)

import Foundation
import SafariServices

/// Add this to any UIViewController to let it easily present a SFSafariView controller using openSafari(url:)
public protocol CanShowSafari {
    @discardableResult
    func openSafari(url: URL, tint: UIColor?) -> SFSafariViewController
}

public extension CanShowSafari where Self: UIViewController {

    @available(iOS 10.0, *)
    @discardableResult
    func openSafari(url: URL, tint: UIColor?) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)

        vc.preferredBarTintColor = tint

        present(vc, animated: true)
        
        return vc
    }

}

#endif
