//
//  File.swift
//  
//
//  Created by Rob Jonson on 28/07/2020.
//

#if !os(watchOS)

import Foundation

import XCTest
@testable import HSHelpers

final class FloatConvertibleTests: XCTestCase {

    func testInt() {

        var float: Float = 4
        XCTAssertEqual(float.int, 4)

        float = 4.5
        XCTAssertEqual(float.int, 4)

        float = 4.9999
        XCTAssertEqual(float.int, 4)

    }

}

#endif
