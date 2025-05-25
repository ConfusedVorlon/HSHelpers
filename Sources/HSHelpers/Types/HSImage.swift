//
//  HSImage.swift
//  FreeFallFilms
//
//  Created by Rob Jonson on 29/06/2023.
//

import Foundation

#if canImport(UIKit)
import UIKit
public typealias HSImage = UIImage

#elseif canImport(AppKit)
import AppKit

public typealias HSImage = NSImage

#endif


#if canImport(SwiftUI)
import SwiftUI


#if canImport(UIKit)


@available(iOS 13.0,tvOS 13.0, *)
public extension Image {
    init(hsImage: HSImage) {
        self.init(uiImage: hsImage)
    }
}

#elseif canImport(AppKit)

@available(macOS 10.15, *)
public extension Image {
    init(hsImage: HSImage) {
        self.init(nsImage: hsImage)
    }
}

#endif

#endif
