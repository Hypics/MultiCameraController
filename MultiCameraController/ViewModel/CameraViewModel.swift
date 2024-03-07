//
//  CameraViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class CameraViewModel: ObservableObject {
  @Published var camera: any Camera

  @Published var downloadMediaEndPoint: String = ""
  @Published var downloadProgress: Double = 0.0

  @Published var showShutterOnToast = false
  @Published var showShutterOffToast = false
  @Published var showDownloadMediaToast = false
  @Published var showRemoveMediaToast = false
  @Published var showRefreshMediaListToast = false

  init(camera: any Camera) {
    self.camera = camera
  }

  func getMediaListCount() -> String {
    "\(String(describing: self.camera.mediaEndPointList.count)) files"
  }

  func startShoot() {
    self.camera.startShoot { result in
      switch result {
      case .success:
        self.showShutterOnToast.toggle()

      case let .failure(error):
        os_log("Error: %@: %@", type: .error, #function, error.localizedDescription)
        return
      }
    }
  }

  func stopShoot() {
    self.camera.stopShoot { result in
      switch result {
      case .success:
        self.showShutterOffToast.toggle()

      case let .failure(error):
        os_log("Error: %@: %@", type: .error, #function, error.localizedDescription)
        return
      }
    }
  }
}

extension CameraViewModel {
  func downloadMediaAll() {
    self.camera.downloadAllMedia { result, mediaEndPoint, progress in
      self.showDownloadMediaToast = true

      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }

      guard let mediaEndPoint else { return }
      guard let progress else { return }

      self.downloadMediaEndPoint = mediaEndPoint
      self.downloadProgress = progress

      if progress > 99.9 {
        self.showDownloadMediaToast = false
      }
    }
  }

  func removeAllMedia() {
    self.camera.removeAllMedia { result in
      switch result {
      case .success:
        self.showRemoveMediaToast.toggle()

      case let .failure(error):
        os_log("Error: %@: %@", type: .error, #function, error.localizedDescription)
        return
      }
    }
  }

  func downloadMedia(mediaEndPoint: String) {
    self.camera.downloadMedia(mediaEndPoint: mediaEndPoint) { result, progress in
      self.showDownloadMediaToast = true

      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }

      guard let progress else { return }

      self.downloadMediaEndPoint = mediaEndPoint
      self.downloadProgress = progress

      if progress > 99.9 {
        self.showDownloadMediaToast = false
      }
    }
  }
}
