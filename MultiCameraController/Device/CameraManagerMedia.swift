//
//  CameraManagerMedia.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension CameraManager {
  func updateMediaEndPointListOfAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      Logger.media.info("\(#function): Update Media EndPoint List (\(index + 1)/\(self.cameraContainer.count))")
      camera.updateMediaEndPointList { result, _ in
        switch result {
        case let .success(response):
          Logger.media.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }

  func downloadAllMediaFromAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      Logger.media.info("\(#function): Download All Media (\(index + 1)/\(self.cameraContainer.count))")
      camera.downloadAllMedia { result, _, _ in
        switch result {
        case let .success(response):
          Logger.media.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }

  func removeAllMediaFromAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      Logger.media.info("\(#function): Rmove All Media (\(index + 1)/\(self.cameraContainer.count))")
      camera.removeAllMedia { result in
        switch result {
        case let .success(response):
          Logger.media.info("Success: \(#function): \(response)")

        case let .failure(error):
          Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        }
      }
    }
  }
}
