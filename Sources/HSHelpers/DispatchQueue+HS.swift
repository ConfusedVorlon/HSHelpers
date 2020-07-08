//
//  DispatchQueue+hs.swift

//
//  Created by Rob Jonson on 21/07/2016.
//  Copyright © 2016 HobbyistSoftware. All rights reserved.
//

import Foundation
import Dispatch

public extension DispatchQueue {
    static var background:DispatchQueue {
        get {
            return DispatchQueue.global(qos: .background)
        }
    }
    
    static var userInitiated:DispatchQueue {
        get {
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
    
    static var userInteractive:DispatchQueue {
        get {
            return DispatchQueue.global(qos: .userInteractive)
        }
    }
    
    func asyncAfter(delay: TimeInterval, execute work: @escaping @convention(block) () -> Swift.Void) {
       self.asyncAfter(deadline: .now() + delay) {
            work()
        }
    }
}
