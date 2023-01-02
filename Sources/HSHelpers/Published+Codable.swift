//
//  Published+Encodable.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 24/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation
import SwiftUI


@available(macOS 10.15,iOS 13.0, *)
extension Published: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let decoded = try Value(from: decoder)
        self = Published(initialValue: decoded)
    }
}

@available(macOS 10.15,iOS 13.0, *)
extension Published: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        try unofficialValue.encode(to: encoder)
    }
}


@available(macOS 10.15,iOS 13.0, *)
private class PublishedWrapper<T> {
    @Published private(set) var value: T

    init(_ value: Published<T>) {
        _value = value
    }
}

@available(macOS 10.15,iOS 13.0, *)
extension Published {
    var unofficialValue: Value {
        PublishedWrapper(self).value
    }
}
