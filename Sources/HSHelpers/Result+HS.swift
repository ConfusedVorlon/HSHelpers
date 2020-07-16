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
}

public extension Result {
    
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    /// Returns whether the instance is `.failure`.
    var isFailure: Bool {
        !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
