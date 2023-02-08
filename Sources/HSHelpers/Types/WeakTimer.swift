import Foundation
import os

/// Convenience wrapper around Timer that auto-invalidates when the parent is released.
/// (Providing you don't capture the parent in the block!)

@available(watchOS 3.0, tvOS 10.0, OSX 10.12, iOS 10.0, *)

public class WeakTimer {
    private var timer: Timer?

    public class func scheduledTimer(withTimeInterval interval: TimeInterval,
                                     repeats: Bool,
                                     block: @MainActor @escaping (Timer) -> Void) -> WeakTimer {



        
        let weakTimer = WeakTimer()
        
        if RunLoop.current == RunLoop.main {
            weakTimer.timer = Timer.scheduledTimer(withTimeInterval: interval,
                                                   repeats: repeats,
                                                   block: block)
        }
        else {
            //if timer isn't scheduled on main runloop - then we'll dispatch the callback to main
            //this ensures we meet the @MainActor contract
#if DEBUG
        runtimeWarning("Weak Timer was scheduled but not on the main runloop. This is probably not intended.")

#endif
            
            weakTimer.timer = Timer.scheduledTimer(withTimeInterval: interval,
                                                   repeats: repeats, block: { timer in
                DispatchQueue.main.async {
                    block(timer)
                }
            })
        }

        return weakTimer
    }

    deinit {
        timer?.invalidate()
    }

    @available(*, deprecated, message: "No need to invalidate - just set to null")
    func invalidate() {
        timer?.invalidate()
    }
}
