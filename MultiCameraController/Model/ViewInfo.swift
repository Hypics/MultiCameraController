//
//  ViewInfo.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation

struct ViewInfo: Hashable {
  static func == (lhs: ViewInfo, rhs: ViewInfo) -> Bool {
    lhs.view == rhs.view
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.view)
  }

  let view: ViewType
  let data: Any?

  init(view: ViewType, data: Any?) {
    self.view = view
    self.data = data
  }

  init(view: ViewType) {
    self.init(view: view, data: nil)
  }
}

enum ViewType {
  case mainView
  case multiCameraView
  case cameraView
  case serverView
}
