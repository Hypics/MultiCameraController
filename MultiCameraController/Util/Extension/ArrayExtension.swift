//
//  ArrayExtension.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/12/24.
//

import Foundation

extension Array {
  mutating func refreshView() {
    if let temp = self.last {
      self.removeLast()
      self.append(temp)
    }
  }
}
