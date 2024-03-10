//
//  CameraManagerPreset.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension CameraManager {
  func setPresetAll(_ cameraPreset: CameraPreset, _ cameraList: [any Camera]?) {
    for camera in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }) {
      camera.setPreset(cameraPreset: cameraPreset) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }
}
