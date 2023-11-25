//
//  File.swift
//  
//
//  Created by Rob Jonson on 25/08/2020.
//

import Foundation
import XCTest

@available(iOS 13.0,tvOS 13.0, *)
final class PublishedCodableTests: XCTestCase {
    static var data: Data!

    override static func setUp() {
        PublishedCodableTests.data = TestStructs.source.data(using: .utf8)!
    }

    func testDecodingSimpleClass() {
        let decoder = JSONDecoder()
        let thing = try? decoder.decode(SimpleClass.self, from: PublishedCodableTests.data)
        XCTAssertNotNil(thing)
        XCTAssertEqual(thing?.anInt, 1)
        XCTAssertEqual(thing?.aBool, true)
        XCTAssertEqual(thing?.aString, "Hello")
    }

    // can't make this work as I can't conform to Decodable and also Expressible by nil literal
//    func testDecodingMissingOptional() {
//        let decoder = JSONDecoder()
//        let thing = try? decoder.decode(MissingOptionalClass.self, from: PublishedCodableTests.data)
//        XCTAssertNotNil(thing)
//    }

//    static var allTests = [
//        ("testDecodeOne", testDecodeOne),
//    ]
}

@available(iOS 13.0, tvOS 13.0,*)
class SimpleClass: ObservableObject, Codable {
    @Published var anInt: Int
    @Published var aBool: Bool
    @Published var aString: String
}

@available(iOS 13.0,tvOS 13.0, *)
class MissingOptionalClass: ObservableObject, Codable {
    @Published var anotherString: String? = "Thing"
}

struct TestStructs {
    static let source: String = """
    {
      "anInt" : 1,
      "aBool" : true,
      "aString" : "Hello"
    }
    """
}
