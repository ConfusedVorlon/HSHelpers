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

    // MARK: - Cached Formatters
    
    private static let shortDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd HH:mm:ss"
        return formatter
    }()
    
    private static let fixedShortDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd HH:mm:ss"
        return formatter
    }()
    
    private static let presentableShortDateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    private static let presentableShortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private static let presentableTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    private static let localTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    private static let presentableLocalTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    // MARK: - String Properties (using cached formatters)

    // see best practice notes at https://nsdateformatter.com/
    // use time style and date style to provide locale aware strings

    @available(*, deprecated, message: "use presentableShortDateTimeString")
    var shortDateTimeString: String {
        return Self.shortDateTimeFormatter.string(from: self)
    }

    var fixedShortDateTimeString: String {
        return Self.fixedShortDateTimeFormatter.string(from: self)
    }

    var presentableShortDateTimeString: String {
        return Self.presentableShortDateTimeFormatter.string(from: self)
    }

    var presentableShortDateString: String {
        return Self.presentableShortDateFormatter.string(from: self)
    }

    @available(*, deprecated, message: "use presentableTmeString")
    var timeString: String {
        return Self.timeFormatter.string(from: self)
    }

    var presentableTimeString: String {
        return Self.presentableTimeFormatter.string(from: self)
    }

    @available(*, deprecated, message: "use presentableLocalTimeString")
    var localTimeString: String {
        return Self.localTimeFormatter.string(from: self)
    }

    var presentableLocalTimeString: String {
        return Self.presentableLocalTimeFormatter.string(from: self)
    }

    // MARK: - Operators and Static Methods

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
