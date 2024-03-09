//
//  ColorExtension.swift
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

  static func initWithHexadecimal(red: Double, green: Double, blue: Double, opacity: Double) -> Color {
    self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, opacity: opacity)
  }

  static func initWithHexadecimal(red: Double, green: Double, blue: Double) -> Color {
    self.initWithHexadecimal(red: red, green: green, blue: blue, opacity: 1.0)
  }
}

extension Color {
  // Color names are from https://colornames.org/search/

  static let hauntedMeadow: Color = .init(hex: "#242424")
  static let charcoalSoul: Color = .init(hex: "#434343")
  static let skyishMyish: Color = .init(hex: "#80ffd5") // .opacity(0.5)
  static let pearlPrincess: Color = .init(hex: "#ffcaca")
  static let summerMorningSkyline: Color = .init(hex: "#c9e9ff")
  static let lightRosea: Color = .init(hex: "#ffbde7")
  static let rawChicien: Color = .init(hex: "#ffb7b0")
}
