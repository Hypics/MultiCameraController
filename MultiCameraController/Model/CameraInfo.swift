//
//  CameraInfo.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation

protocol CameraInfo {
  var ap_mac_addr: String { get set }
  var ap_ssid: String { get set }
  var firmware_version: String { get set }
  var model_name: String { get set }
  var model_number: String { get set }
  var serial_number: String { get set }
}
