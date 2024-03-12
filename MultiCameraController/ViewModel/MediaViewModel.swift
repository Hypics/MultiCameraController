//
//  MediaViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import OSLog

class MediaViewModel: ObservableObject {
  @Published var downloadMediaEndPoint: String = ""
  @Published var downloadProgress: Double = 0.0

  @Published var showDownloadMediaToast = false
  @Published var showRemoveMediaToast = false
  @Published var showRefreshMediaListToast = false

  func downloadMedia(camera: any Camera, mediaEndPoint: String) {
    camera.downloadMedia(mediaEndPoint: mediaEndPoint) { result, progress in
      self.showDownloadMediaToast = true

      switch result {
      case let .success(response):
        Logger.media.info("Success: \(#function): \(response)")

      case let .failure(error):
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
      }

      guard let progress else { return }

      self.downloadMediaEndPoint = mediaEndPoint
      self.downloadProgress = progress

      if progress > 99.9 {
        self.showDownloadMediaToast = false
      }
    }
  }

  func removeMedia(camera: any Camera, at offsets: IndexSet) {
    camera.removeMedia(at: offsets)
    self.showRemoveMediaToast.toggle()
  }
}
