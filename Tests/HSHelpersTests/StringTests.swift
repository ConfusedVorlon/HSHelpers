//
//  File.swift
//  
//
//  Created by Rob Jonson on 14/07/2020.
//

import Foundation

import XCTest
@testable import HSHelpers

final class StringTests: XCTestCase {
    
    func testTruncate() {
        
        var jerome = "Jérôme Faure"
        jerome.truncate(to: 4)
        XCTAssertEqual(jerome,"Jérô...")
        
        var exact = "Two"
        exact.truncate(to: 2)
        XCTAssertEqual(exact,"Tw...")
        
        exact = "Two"
        exact.truncate(to: 3)
        XCTAssertEqual(exact,"Two")
        
        exact = "Two"
        exact.truncate(to: 4)
        XCTAssertEqual(exact,"Two")
        
    }
    
    func testIsInteger() {
        XCTAssertTrue("125".isInteger)
        XCTAssertFalse("125.11".isInteger)
        XCTAssertFalse("125a".isInteger)

    }

}
