//
//  CameraManagerPreset.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension CameraManager {
  func setPresetAll(_ cameraPreset: CameraPreset) {
    for camera in self.cameraContainer {
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
