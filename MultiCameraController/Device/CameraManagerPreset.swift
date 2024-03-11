//
//  CameraManagerPreset.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension CameraManager {
  func setPresetAll(_ cameraPreset: CameraPreset, _ cameraList: [any Camera]?) {
    for camera in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }) {
      camera.setPreset(cameraPreset: cameraPreset) { result in
        switch result {
        case let .success(response):
          Logger.setting.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }
}
