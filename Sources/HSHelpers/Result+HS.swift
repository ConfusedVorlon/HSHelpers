//
//  Result+HS.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 17/03/2020.
//

import Foundation

public extension Result where Success == Void {
    static var success: Result {
        return .success(())
    }
    
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    /// Returns whether the instance is `.failure`.
    var isFailure: Bool {
        !isSuccess
    }
}
