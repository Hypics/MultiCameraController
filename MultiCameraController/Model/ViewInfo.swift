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
  case serverView
}

enum PanelType: CaseIterable {
  case controlPanel
  case settingPanel
  case mediaPanel

  static func getNext(after currentCase: PanelType) -> PanelType? {
    guard let currentIndex = PanelType.allCases.firstIndex(of: currentCase) else { return nil }
    let nextIndex = (currentIndex + 1) % PanelType.allCases.count
    return PanelType.allCases[nextIndex]
  }

  func toTitle() -> String {
    switch self {
    case .controlPanel:
      "Control"

    case .settingPanel:
      "Setting"

    case .mediaPanel:
      "Media"
    }
  }
}
