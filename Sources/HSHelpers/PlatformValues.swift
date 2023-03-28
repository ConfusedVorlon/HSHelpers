//
//  PlatformValues.swift
//  Chatter
//
//  Created by Rob Jonson on 28/03/2023.
//

import Foundation

//Inspired by Jesse Squires
//https://www.jessesquires.com/blog/2023/03/23/improve-multiplatform-swiftui-code/

//This allows you to initialise most simple types with a platform-specific initialiser
//let padding = Double(iOS:20,watchOS:5,macOS:10,tvOS:30)
//let device = String(iOS: "I'm an iPhone", macOS: "I'm a Mac!")


public extension Encodable {
    init(iOS: Self, watchOS: Self, macOS: Self, tvOS: Self) {
        #if os(iOS)
        self = iOS
        #elseif os(watchOS)
        self = watchOS
        #elseif os(tvOS)
        self = tvOS
        #elseif os(macOS)
        self = macOS
        #else
        fatalError()
        #endif
    }
    
    //Use this if you're not building for watchOS
    init(iOS: Self, macOS: Self) {
        #if os(iOS)
        self = iOS
        #elseif os(macOS)
        self = macOS
        #else
        fatalError()
        #endif
    }
}


