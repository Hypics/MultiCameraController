//
//  ColorExtensions.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/21/23.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")

    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)

    let red = Double((rgb >> 16) & 0xFF) / 255.0
    let green = Double((rgb >> 8) & 0xFF) / 255.0
    let blue = Double((rgb >> 0) & 0xFF) / 255.0
    self.init(red: red, green: green, blue: blue)
  }

  init(hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 08) & 0xFF) / 255,
      blue: Double((hex >> 00) & 0xFF) / 255,
      opacity: alpha
    )
  }
}
