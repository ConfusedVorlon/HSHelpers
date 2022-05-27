//
//  Runtime Warning
//  Allows you to raise a runtime warning which shows up as a purple triangle in XCode (like with the thread checker warnings)
//  runtime("Naughty Runtime Warning",args...)
//
//  from
//  https://github.com/pointfreeco/swift-composable-architecture/
// https://github.com/pointfreeco/swift-composable-architecture/blob/96f47fbe858da6084ec31ee7e31c8a310ecb8168/LICENSE




#if DEBUG
  import os

  // NB: Xcode runtime warnings offer a much better experience than traditional assertions and
  //     breakpoints, but Apple provides no means of creating custom runtime warnings ourselves.
  //     To work around this, we hook into SwiftUI's runtime issue delivery mechanism, instead.
  //
  // Feedback filed: https://gist.github.com/stephencelis/a8d06383ed6ccde3e5ef5d1b3ad52bbc
@available(iOS 10.0, *)
private let rw = (
    dso: { () -> UnsafeMutableRawPointer in
      let count = _dyld_image_count()
      for i in 0..<count {
        if let name = _dyld_get_image_name(i) {
          let swiftString = String(cString: name)
          if swiftString.hasSuffix("/SwiftUI") {
            if let header = _dyld_get_image_header(i) {
              return UnsafeMutableRawPointer(mutating: UnsafeRawPointer(header))
            }
          }
        }
      }
      return UnsafeMutableRawPointer(mutating: #dsohandle)
    }(),
    log: OSLog(subsystem: "com.apple.runtime-issues", category: "ComposableArchitecture")
  )
#endif

@_transparent
@inline(__always)
func runtimeWarning(
  _ message: @autoclosure () -> StaticString,
  _ args: @autoclosure () -> [CVarArg] = []
) {
    if #available(iOS 12.0, *) {
#if DEBUG
        let message = message()
        unsafeBitCast(
            os_log as (OSLogType, UnsafeRawPointer, OSLog, StaticString, CVarArg...) -> Void,
            to: ((OSLogType, UnsafeRawPointer, OSLog, StaticString, [CVarArg]) -> Void).self
        )(.fault, rw.dso, rw.log, message, args())
#endif
    } else {
        print(message(),args())
    }
}
