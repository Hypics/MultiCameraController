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
  @Published var goProInfo: GoProInfo?

  @Published var mediaEndPointList: [String] = []

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

  func getCameraSerialNumber() -> String {
    "GoPro \(self.camera.serialNumber)"
  }

  func getMediaListCount() -> String {
    "\(String(describing: self.mediaEndPointList.count)) files"
  }

  func startShooting() {
    os_log("Shutter On", type: .info)
    self.camera.requestUsbCommand(command: .shutterOn) { error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        return
      }
    }
    self.showShutterOnToast.toggle()
  }

  func stopShooting() {
    os_log("Shutter Off", type: .info)
    self.camera.requestUsbCommand(command: .shutterOff) { error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        return
      }
    }
    self.showShutterOffToast.toggle()
  }

  func getCameraInfo() {
    os_log("Get camera info: GoPro %@", type: .info, self.camera.serialNumber)
    self.camera.requestUsbCameraInfo { goProInfo, error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        return
      }
      self.goProInfo = goProInfo
    }

  }
}

extension CameraViewModel {
  func downloadMediaAll() {
    os_log("Download Media All", type: .info)
    for mediaEndPoint in self.mediaEndPointList {
      self.showDownloadMediaToast = true
      self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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

  func removeMediaAll() {
    os_log("Remove Media All", type: .info)
    for mediaUrl in self.mediaEndPointList {
      self.camera.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showRemoveMediaToast.toggle()
  }

  func downloadMedia(mediaEndPoint: String) {
    os_log("Download Media: %@", type: .info, mediaEndPoint)
    self.showDownloadMediaToast = true
    self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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

  func downloadMediaList() {
    os_log("Download media list: GoPro %@", type: .info, self.camera.serialNumber)
    self.camera.requestUsbMediaList { mediaEndPointList, _, error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        return
      }
      self.mediaEndPointList = mediaEndPointList ?? []
    }
    self.showRefreshMediaListToast.toggle()
  }

  func deleteMediaItem(at offsets: IndexSet) {
    self.camera
      .requestUsbMediaRemove(
        mediaEndPoint: self
          .mediaEndPointList[offsets[offsets.startIndex]]
      ) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        self.mediaEndPointList.remove(atOffsets: offsets)
      }
  }
}
