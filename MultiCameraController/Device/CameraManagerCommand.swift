//
//  CameraManagerCommand.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension CameraManager {
  func startShootAll(_ cameraList: [any Camera]?) {
    for camera in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }) {
      camera.startShoot { result in
        switch result {
        case let .success(response):
          Logger.camera.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }

  func stopShootAll(_ cameraList: [any Camera]?) {
    for camera in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }) {
      camera.stopShoot { result in
        switch result {
        case let .success(response):
          Logger.camera.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }

  func checkCameraAll(_ cameraList: [any Camera]?) {
    for camera in cameraList ?? self.cameraContainer {
      camera.checkConnection { result in
        switch result {
        case let .success(response):
          Logger.camera.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }

  func enableWiredUsbControlAll(_ cameraList: [any Camera]?) {
    for camera in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }) {
      camera.enableWiredUsbControl { result in
        switch result {
        case let .success(response):
          Logger.camera.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }
}
