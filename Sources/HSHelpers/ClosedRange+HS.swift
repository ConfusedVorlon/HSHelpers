//
//  ClosedRange+HS.swift
//  Dynamic Wallpaper Builder
//
//  Created by Rob Jonson on 20/12/2018.
//  Copyright © 2018 HobbyistSoftware. All rights reserved.
//

import Foundation

extension ClosedRange {
    init(a:Bound,b:Bound) {
        if a<b {
            self.init(uncheckedBounds: (lower: a, upper: b))
        }
        else {
            self.init(uncheckedBounds: (lower: b, upper: a))
        }
    }
}
