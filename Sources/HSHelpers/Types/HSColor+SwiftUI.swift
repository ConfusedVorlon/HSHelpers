//
//  File.swift
//  
//
//  Created by Rob Jonson on 02/01/2023.
//

import Foundation

#if canImport(SwiftUI)
import SwiftUI

    #if canImport(UIKit)
    import UIKit
        @available(iOS 15.0,tvOS 15.0, *)
        public extension Color {
            init(hsColor:HSColor){
                self.init(uiColor: hsColor)
            }
        }

    #elseif canImport(AppKit)
    import AppKit
        @available(macOS 12.0, *)
        public extension Color {
            init(hsColor:HSColor){
                self.init(nsColor: hsColor)
            }
        }
    #endif

@available(iOS 15.0,macOS 12.0, tvOS 15.0,*)
public extension Color {
    static let label = Color(hsColor: .label)
    static let secondaryLabel = Color(hsColor: .secondaryLabel)
    static let tertiaryLabel = Color(hsColor: .tertiaryLabel)
    static let quaternaryLabel = Color(hsColor: .quaternaryLabel)
    static let placeholderText = Color(hsColor: .placeholderText)
    static let separator = Color(hsColor: .separator)
    static let link = Color(hsColor:.link)

    
    #if !os(tvOS)
    static let systemBackground = Color(hsColor:.systemBackground)
    static let secondarySystemBackground = Color(hsColor:.secondarySystemBackground)
    
    static let systemGray = Color(hsColor:.systemGray)
    static let systemGray2  = Color(hsColor:.systemGray2)
    static let systemGray3 = Color(hsColor:.systemGray3)
    static let systemGray4  = Color(hsColor:.systemGray4)
    static let systemGray5  = Color(hsColor:.systemGray5)
    static let systemGray6  = Color(hsColor:.systemGray6)
    #endif
}

//canImport(SwiftUI)
#endif
