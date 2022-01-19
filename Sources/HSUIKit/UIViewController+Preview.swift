//
//  UIDocumentInteractionController+HS.swift
//  Rhythm101
//
//  Created by Rob Jonson on 13/12/2018.
//  Copyright © 2018 Tinkerswitch. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS) && !os(tvOS)

import Foundation
import UIKit

public protocol CanShowPreview {
    func openPreview(url: URL, animated: Bool)
}

public extension CanShowPreview where Self: UIViewController {

    func openPreview(url: URL, animated: Bool = true) {
        let preview = UIDocumentInteractionController(url: url)

        let vcHolder = VCDelegateForDocumentInteractionPresentation.init(viewController: self)

        // vcHolder could be deallocated before presentPreview
        withExtendedLifetime(vcHolder) {
            preview.delegate = vcHolder
            preview.presentPreview(animated: animated)
        }
    }

}

// swiftlint:disable:next type_name
private class VCDelegateForDocumentInteractionPresentation: NSObject, UIDocumentInteractionControllerDelegate {
    var viewController: UIViewController

    init(viewController aVC: UIViewController) {
        viewController = aVC
        super.init()
    }

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return viewController
    }

}

#endif
