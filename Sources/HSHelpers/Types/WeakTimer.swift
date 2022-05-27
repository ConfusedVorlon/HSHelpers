import Foundation
import os

/// Convenience wrapper around Timer that auto-invalidates when the parent is released.
/// (Providing you don't capture the parent in the block!)

@available(watchOS 3.0, tvOS 10.0, OSX 10.12, iOS 10.0, *)

public class WeakTimer {
    private var timer: Timer?

    public class func scheduledTimer(withTimeInterval interval: TimeInterval,
                                     repeats: Bool,
                                     block: @escaping (Timer) -> Void) -> WeakTimer {


#if DEBUG
        if RunLoop.current != RunLoop.main {
            runtimeWarning("Weak Timer was scheduled but not on the main runloop. This is probably not intended.")
          
        }
#endif
        
        let weakTimer = WeakTimer()
        weakTimer.timer = Timer.scheduledTimer(withTimeInterval: interval,
                                               repeats: repeats,
                                               block: block)

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
