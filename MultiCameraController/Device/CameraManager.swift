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

  public var cameraSerialNumberList =
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []

  public var cameraContainer: [any Camera] = (
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  )
  .reduce([any Camera]()) { result, item in
    var temp = result
    temp.append(GoPro(serialNumber: item))
    return temp
  }

  func getConnectedCameraContainer() -> [any Camera] {
    self.cameraContainer.filter { $0.isConnected == true }
  }

  func getConnectedCameraCount() -> Int {
    self.cameraContainer.filter { $0.isConnected == true }.count
  }

  func addCamera(newCameraSerialNumber: String) {
    if newCameraSerialNumber.count == 3, newCameraSerialNumber.isInt(),
       !self.cameraContainer.contains(where: { $0.serialNumber == newCameraSerialNumber })
    {
      self.cameraSerialNumberList.append(newCameraSerialNumber)
      self.cameraContainer
        .append(GoPro(serialNumber: newCameraSerialNumber))
      self.cameraContainer.last?.checkConnection(nil)
      self.cameraContainer.last?.enableWiredUsbControl(nil)
    } else {
      os_log("%@ is not a serial number (3 digits)", type: .error, newCameraSerialNumber)
    }
  }

  func moveCamera(from source: IndexSet, to destination: Int) {
    self.cameraSerialNumberList.move(fromOffsets: source, toOffset: destination)
    self.cameraContainer.move(fromOffsets: source, toOffset: destination)
  }

  func removeCamera(at offsets: IndexSet) {
    self.cameraSerialNumberList.remove(atOffsets: offsets)
    self.cameraContainer.remove(atOffsets: offsets)
  }

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
    for camera in self.getConnectedCameraContainer() {
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

  func enableWiredUsbControlAll() {
    for camera in self.getConnectedCameraContainer() {
      camera.enableWiredUsbControl { result in
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
    for camera in self.getConnectedCameraContainer() {
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
    for camera in self.getConnectedCameraContainer() {
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
    camera.downloadAllMedia { result, _, _ in
      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }
    }
  }

  func downloadAllMediaFromAllCamera() {
    for (index, camera) in self.getConnectedCameraContainer().enumerated() {
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
    for (index, camera) in self.getConnectedCameraContainer().enumerated() {
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
