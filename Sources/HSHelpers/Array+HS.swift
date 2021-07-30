//
//  Array+HS.swift

//
//  Created by Rob Jonson on 23/08/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation

public extension Array where Element == String {
    func sortedFinderwise() -> [String] {
        return self.sorted(by:{ x,y in
            return x.localizedStandardCompare(y) == ComparisonResult.orderedAscending
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

public extension Array where Element : Hashable {
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
    func clipped(toMaxLength maxLength:Int) -> [Element]{
        if self.count <= maxLength {
            return self as! [Self.Element]
        }
        
        return Array(self[0..<maxLength])
    }
}



