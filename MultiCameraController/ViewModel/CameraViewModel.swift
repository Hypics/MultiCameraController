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

  @Published var downloadMediaUrl: String = ""
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
    "\(String(describing: self.camera.mediaUrlStringList.count)) files"
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
    self.camera.downloadAllMedia { result, mediaUrl, progress in
      self.showDownloadMediaToast = true

      switch result {
      case let .success(response):
        os_log("Success: %@: %@", type: .info, #function, response)

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
      }

      guard let mediaUrl else { return }
      guard let progress else { return }

      self.downloadMediaUrl = mediaUrl
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
    os_log("Download Media: %@", type: .info, mediaEndPoint)
    self.showDownloadMediaToast = true
    self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
      if let error {
        os_log("Error: %@", type: .error, error.localizedDescription)
        return
      }
      if let progress {
        if progress > 99.9 {
          self.showDownloadMediaToast = false
        }
        self.downloadMediaUrl = mediaEndPoint
        self.downloadProgress = progress
      }
    }
  }
}
