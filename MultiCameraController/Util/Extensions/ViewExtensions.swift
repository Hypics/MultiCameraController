//
//  ViewExtensions.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

extension View {
  func blinkView(_ opacity: Bool) -> some View {
    self.opacity(opacity ? 1.0 : 0.0)
      .animation(
        .linear(duration: 1.0)
          .repeatCount(2)
      )
  }
}
