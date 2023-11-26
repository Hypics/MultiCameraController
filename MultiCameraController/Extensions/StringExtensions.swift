//
//  StringExtensions.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/21/23.
//

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

  func substring(with r: Range<Int>) -> String {
    let startIndex = self.index(from: r.lowerBound)
    let endIndex = self.index(from: r.upperBound)
    return String(self[startIndex ..< endIndex])
  }
}
