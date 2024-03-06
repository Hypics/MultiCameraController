//
//  CameraManager.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class CameraManager {
  static let instance: CameraManager = .init()
  public var cameraContainer: [any Camera] = (
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  )
  .reduce([any Camera]()) { result, item in
    var temp = result
    temp.append(GoPro(serialNumber: item))
    return temp
  }

  func addCamera(camera _: any Camera) {}

  func removeCamera(camera _: any Camera) {}

  func checkCamera(camera: any Camera) {
    camera.checkConnection { result in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func checkCameraAll() {
    for camera in self.cameraContainer {
      camera.checkConnection { result in
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

extension CameraManager {
  func startShootAll() {
    for camera in self.cameraContainer {
      camera.startShoot { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func stopShootAll() {
    for camera in self.cameraContainer {
      camera.stopShoot { result in
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

extension CameraManager {
  func downloadMediaFromCamera(camera: any Camera, mediaUrl: String) {
    camera.downloadMedia(mediaUrl: mediaUrl) { result, _ in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func downloadAllMediaFromCamera(camera: any Camera) {
    camera.downloadAllMedia { result, _ in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func downloadAllMediaFromAllCamera() {
    for (index, camera) in self.cameraContainer.enumerated() {
      os_log("Download All Media (%@/%@", type: .info, index + 1, self.cameraContainer.count)
      camera.downloadAllMedia { result, _ in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func removeMediaFromCamera(camera: any Camera, mediaUrl: String) {
    camera.removeMedia(mediaUrl: mediaUrl) { result in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func removeAllMediaFromCamera(camera: any Camera) {
    camera.removeAllMedia { result in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func removeAllMediaFromAllCamera() {
    for (index, camera) in self.cameraContainer.enumerated() {
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
