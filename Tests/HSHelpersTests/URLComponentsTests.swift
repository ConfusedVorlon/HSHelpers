//
//  File.swift
//  
//
//  Created by Rob Jonson on 14/07/2020.
//

#if !os(watchOS)
import XCTest
@testable import HSHelpers

final class URLComponentsTests: XCTestCase {

    // using URLSearchParams in js will encode spaces as + and + as %2B
    func testTreatUnencodedPlussesAsSpaces() {
        // swiftlint:disable:next line_length
        let link = "https://mmw.app.link/db?u=https%3A%2F%2Fwllp.art%2Fwallpapers%2F20%2Fdownload&t=Venice+%2B+Beach&a=Rob+Jonson&p=https%3A%2F%2Fwllp.art%2F"

        var components = URLComponents(string: link)!
        components.treatUnencodedPlussesAsSpaces()

        // Confirms both that the spaces have survived, and also that the + between them is ok
        XCTAssertEqual(components["t"], "Venice + Beach")
    }

}
#endif
