//
//  CameraManagerMedia.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension CameraManager {
  func updateMediaEndPointListOfAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log("Update Media EndPoint List (%@/%@)", type: .info, index + 1, self.cameraContainer.count)
      camera.updateMediaEndPointList { result, _ in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func downloadAllMediaFromAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log("Download All Media (%@/%@)", type: .info, index + 1, self.cameraContainer.count)
      camera.downloadAllMedia { result, _, _ in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func removeAllMediaFromAllCamera(_ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log("Rmove All Media (%@/%@)", type: .info, index + 1, self.cameraContainer.count)
      camera.removeAllMedia { result in
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
