//
//  DateExtension.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation

extension Date {
  func toString(_ customDateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = customDateFormat
    return dateFormatter.string(from: self)
  }

  func toString(_ customDateFormat: String, timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = customDateFormat
    return dateFormatter.string(from: self)
  }

  func year(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "yyyy"
    return dateFormatter.string(from: self)
  }

  func month(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "MM"
    return dateFormatter.string(from: self)
  }

  func date(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "dd"
    return dateFormatter.string(from: self)
  }

  func hour(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "HH"
    return dateFormatter.string(from: self)
  }

  func minute(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "mm"
    return dateFormatter.string(from: self)
  }

  func second(timeZone: TimeZone?) -> String {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = "ss"
    return dateFormatter.string(from: self)
  }

  func addYear(year: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.year = year
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }

  func addMonth(month: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.month = month
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }

  func addDay(day: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.day = day
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }

  func addHour(hour: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.hour = hour
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }

  func addMinute(minute: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.minute = minute
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }

  func addSecond(second: Int) -> Date? {
    var dateComponent = DateComponents()
    dateComponent.second = second
    let calendar = Calendar.current
    return calendar.date(byAdding: dateComponent, to: Date())
  }
}

enum CustomDateFormat: String {
  case yearToDay = "yyyyMMdd"
  case yearToSecond = "yyyyMMdd HHmmss"
  case yearToFractionalSecond = "yyyyMMdd HHmmss.SSSZ"
  case yearToFractionalSecondSquareBracket = "[yyyy-MM-dd HH:mm:ss.SSSZ]"
  case simpleYearToSecond = "yyMMdd_HHmmss"
  case simpleYearToFractionalSecond = "yyMMdd-HHmmss.SSSZ"
}
