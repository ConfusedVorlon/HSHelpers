//
//  File.swift
//  
//
//  Created by Rob Jonson on 10/04/2021.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UIViewController {

    @objc
    func share(items: [ShareItem], sourceView: UIView? = nil, permittedArrowDirections: UIPopoverArrowDirection = []) {

        guard let view = sourceView ?? self.view else {
            return
        }

        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)

        if let popoverPC = activityViewController.popoverPresentationController {
            popoverPC.sourceView = view
            popoverPC.sourceRect = view.bounds
            popoverPC.permittedArrowDirections = permittedArrowDirections
        }

        self.present(activityViewController, animated: true)

    }
}

@objc
public class ShareItem: NSObject, UIActivityItemSource {

    private let subject: String
    private let item: Any

    public init(subject: String, item: Any) {
        self.subject = subject
        self.item = item

        super.init()
    }

    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return item
    }

    public func activityViewController(_ activityViewController: UIActivityViewController,
                                       itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return item
    }

    public func activityViewController(_ activityViewController: UIActivityViewController,
                                       subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return subject
    }
}

#endif
