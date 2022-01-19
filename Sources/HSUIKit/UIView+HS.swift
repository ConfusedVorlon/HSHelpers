//
//  UIViewExtension.swift

//
//  Created by Rob Jonson on 22/06/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import UIKit

public extension UIView {

    func border(width: CGFloat = 1.0, colour: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = colour.cgColor
    }

    class func forAutoLayout() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func shadow(height: CGFloat, colour: UIColor = UIColor.gray) {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.init(width: -height*0.7, height: height*0.7)
        self.layer.shadowRadius = height
    }

    /// offscreen capture. Seems to be marginally faster than hsOffscreenImage
    /// requires main thread
    ///
    /// If this doesn't work, that probably means the layer is the wrong size.
    /// This can happen with autolayout views taken offscreen
    ///
    /// - parameter scale:  scale to render
    /// - parameter opaque: if opaque, then background has black layer
    ///
    /// - returns: image
    func hsOffscreenImage( scale: CGFloat =  0, afterScreenUpdates: Bool = true ) -> UIImage? {
        var scale = scale
        if scale == 0 {
            scale = self.contentScaleFactor
        }

        let rect = self.bounds
        var image: UIImage?

        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)

        // afterScreenUpdates needs to be true for animation to work
        let success = self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterScreenUpdates)
        if success {
            image = UIGraphicsGetImageFromCurrentImageContext()
        } else {
            print("Warning - failed to get image for \(self)")
        }
        UIGraphicsEndImageContext()

        print("Made image scale: \(String(describing: image?.scale)), size: \(String(describing: image?.size))")

        return image
    }

    /// offscreen capture. Seems to be marginally faster than hsOffscreenImage
    /// works in background thread
    ///
    /// - parameter scale:  scale to render
    /// - parameter opaque: if opaque, then background has black layer
    ///
    /// - returns: image
    func hsOffscreenImage2(scale: CGFloat =  0, opaque: Bool = false) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    func useFadeToAnimateLayer(duration: TimeInterval) {
        // fade changes to the layer
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.layer.add(transition, forKey: CATransitionType.fade.rawValue)
    }

    func removeSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }

    @discardableResult
    func addConstraints(withVisualFormat format: String,
                        options opts: NSLayoutConstraint.FormatOptions = [.directionLeftToRight],
                        metrics: [String: Any]?,
                        views: [String: Any]) -> [NSLayoutConstraint] {

        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                         options: opts,
                                                         metrics: metrics,
                                                         views: views)

        addConstraints(constraints)

        return constraints
    }
}

#endif
