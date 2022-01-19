//
//  Array+HS.swift

//
//  Created by Rob Jonson on 23/08/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension Array {
    mutating func safeRemoveFirst() -> Element? {
        if self.count == 0 {
            return nil
        }
        return self.removeFirst()
    }
}

public extension Array where Element == String {
    /// Sorts using same logic as finder
    /// - Returns: sorted array
    func sortedFinderwise() -> [String] {
        return self.sorted(by: { left, right in
            return left.localizedStandardCompare(right) == ComparisonResult.orderedAscending
        })
    }
}

public extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }

    mutating func remove(elements: [Element]) {
        self.removeAll { elements.contains($0) }
    }

}

public extension Array where Element: Hashable {
    /// Get unique elements of array
    /// - Returns: array
    func unique() -> [Element] {
        return Array(Set(self))
    }
}

public extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Collection where Self.Index == Int {
    func clipped(toMaxLength maxLength: Int) -> [Element] {
        if self.count <= maxLength {
            // Can anyone explain to me why I have to do the cast at all here??
            // swiftlint:disable:next force_cast
            return self as! [Self.Element]
        }

        return Array(self[0..<maxLength])
    }
}
