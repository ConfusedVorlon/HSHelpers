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

//These are now in the OptionalType file so that it does't have to be included when not needed
//func removeNils() -> [Iterator.Element.Wrapped]
//var nonNilCount:Int

//Shuffle seems to be in the standard library
////https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
//extension MutableCollection {
//    /// Shuffles the contents of this collection.
//    mutating func shuffle() {
//        let c = count
//        guard c > 1 else { return }
//
//        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
//            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
//            let i = index(firstUnshuffled, offsetBy: d)
//            swapAt(firstUnshuffled, i)
//        }
//    }
//}

//MARK: Shuffling

public extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


public extension Array {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
    @available(*, deprecated, message: "use randomElement()")
    func randomItem() -> Iterator.Element {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomIndex]
    }

    func safeRemoveFirst() -> Element? {
        if self.count == 0 {
            return nil
        }
        return self.removeFirst()
    }
}

