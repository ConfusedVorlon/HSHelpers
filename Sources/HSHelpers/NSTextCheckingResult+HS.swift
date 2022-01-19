//
//  Created by Rob Jonson on 08/01/2021.
//

import Foundation

public extension NSTextCheckingResult {

    /// Returns groups in regex result
    /// - Parameter testedString: the original source
    /// - Returns: array of matches. Note that the 0th element is the whole match, the 1st is the first captured group
    func groups(testedString: String) -> [String] {
        var groups = [String]()
        for i in  0 ..< self.numberOfRanges {
            let group = String(testedString[Range(self.range(at: i), in: testedString)!])
            groups.append(group)
        }
        return groups
    }
}
