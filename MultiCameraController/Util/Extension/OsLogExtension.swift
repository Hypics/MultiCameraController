//
//  OsLogExtension.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/11/24.
//

import Foundation
import OSLog

extension Logger {
  static let subsystem = Bundle.main.bundleIdentifier ?? ""
  static let camera = Logger(subsystem: subsystem, category: "Camera")
  static let setting = Logger(subsystem: subsystem, category: "Setting")
  static let media = Logger(subsystem: subsystem, category: "Media")
  static let server = Logger(subsystem: subsystem, category: "Server")
}
