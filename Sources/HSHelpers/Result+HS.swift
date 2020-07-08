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
