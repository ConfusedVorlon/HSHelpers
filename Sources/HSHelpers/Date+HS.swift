//
//  Date+HS.swift
//  Pods
//
//  Created by Rob Jonson on 07/11/2016.
//
//

import Foundation

public extension Date {

    /// Date.now is more descriptive than Date()
    static var now: Date {
        return Date()
    }

    var isInTheFuture: Bool {
        return self.timeIntervalSinceNow > 0
    }

    var isInThePast: Bool {
        return self.timeIntervalSinceNow < 0
    }

    /// Provides a positive value for dates in the past
    var secondsAgo: TimeInterval {
        return -self.timeIntervalSinceNow
    }

    // see best practice notes at https://nsdateformatter.com/
    // use time style and date style to provide locale aware strings

    @available(*, deprecated, message: "use presentableShortDateTimeString")
    var shortDateTimeString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM-dd HH:mm:ss"
        let result = dateFormat.string(from: self)
        return result
    }

    var fixedShortDateTimeString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM-dd HH:mm:ss"
        let result = dateFormat.string(from: self)
        return result
    }

    var presentableShortDateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    var presentableShortDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    @available(*, deprecated, message: "use presentableTmeString")
    var timeString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        let result = dateFormat.string(from: self)
        return result
    }

    var presentableTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    @available(*, deprecated, message: "use presentableLocalTimeString")
    var localTimeString: String {
        let dateFormat = DateFormatter()
        dateFormat.timeZone = TimeZone.current
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: self)
    }

    var presentableLocalTimeString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    static func - (left: Date, right: Date) -> TimeInterval { // 1
        return left.timeIntervalSince(right)
    }

    static func with(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute

        return calendar.date(from: dateComponents) ?? nil
    }

    static func todayAt(hour: Int = 0, minute: Int = 0) -> Date? {
        let calendar = Calendar(identifier: .gregorian)

        let todayDate = calendar.date(bySettingHour: hour,
                                      minute: minute,
                                      second: 0,
                                      of: Date())

        return todayDate!

    }

}
