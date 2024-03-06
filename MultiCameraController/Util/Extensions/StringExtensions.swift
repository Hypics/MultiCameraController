//
//  StringExtensions.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/21/23.
//

import Foundation

extension String {
  func isInt() -> Bool {
    Int(self) != nil
  }

  func index(from: Int) -> Index {
    self.index(startIndex, offsetBy: from)
  }

  func substring(from: Int) -> String {
    let fromIndex = self.index(from: from)
    return String(self[fromIndex...])
  }

  func substring(to: Int) -> String {
    let toIndex = self.index(from: to)
    return String(self[..<toIndex])
  }

  func substring(with range: Range<Int>) -> String {
    let startIndex = self.index(from: range.lowerBound)
    let endIndex = self.index(from: range.upperBound)
    return String(self[startIndex ..< endIndex])
  }

  func toDate(format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: self)
  }

  func toDate(format: String, timeZone: TimeZone?) -> Date? {
    let dateFormatter = DateFormatter()
    if let timeZone {
      dateFormatter.timeZone = timeZone
    }
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: self)
  }
}
