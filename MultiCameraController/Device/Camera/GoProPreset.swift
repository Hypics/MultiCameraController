//
//  GoProPreset.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension GoPro {
  func setPreset(cameraPreset: CameraPreset, _ completion: ((Result<Bool, Error>) -> Void)?) {
    for setting in cameraPreset.toGoProSetting() {
      self.requestUsbSetting(setting: setting) { error in
        if let error {
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
          completion?(.failure(error))
          return
        }
      }
    }
  }
}
