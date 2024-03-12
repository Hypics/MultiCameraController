//
//  MultiCameraViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import OSLog

class MultiCameraViewModel: ObservableObject {
  @Published var downloadMediaEndPoint: String = ""
  @Published var downloadProgress: Double = 0.0

  @Published var showShutterOnToast = false
  @Published var showShutterOffToast = false
  @Published var showDownloadMediaToast = false
  @Published var showRemoveMediaToast = false
  @Published var showRefreshCameraListToast = false

  func getCreationTimestamp(completion: @escaping (Int) -> Void) {
    var creationTimestamp = 2_147_483_647
    for (index, camera) in CameraManager.instance.cameraContainer.filter({ $0.isConnected == true }).enumerated() {
      camera.requestUsbMediaList { _, latestCreationTimestamp, error in
        if let error {
          Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
          return
        }
        creationTimestamp = min(creationTimestamp, latestCreationTimestamp)

        if index == CameraManager.instance.getConnectedCameraCount() - 1 {
          completion(creationTimestamp)
        }
      }
    }
  }

  func deleteCameraItem(at offsets: IndexSet) {
    Logger.camera.info("Remove \(CameraManager.instance.cameraContainer[offsets[offsets.startIndex]].cameraName)")
    CameraManager.instance.removeCamera(at: offsets)
    UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
  }

  func downloadMediaAll(_ cameraList: [any Camera]) {
    Logger.media.info("Download Media All")
    self.getCreationTimestamp { creationTimestamp in
      let creationDate = Date(timeIntervalSince1970: TimeInterval(creationTimestamp))
      let creationDateString = creationDate.toString(CustomDateFormat.simpleYearToSecond.rawValue)

      Logger.media.info("creationTimestamp: \(creationDateString) from \(creationTimestamp.description)")
      for camera in cameraList.filter({ $0.isConnected == true }) {
        Logger.media.info("Download Media List: \(camera.cameraName)")
        camera.requestUsbMediaList { mediaEndPointList, _, error in
          if let error {
            Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
            return
          }

          for mediaEndPoint in mediaEndPointList ?? [] {
            self.showDownloadMediaToast = true
            camera
              .requestUsbMediaDownload(
                mediaEndPoint: mediaEndPoint,
                timestamp_path: creationDateString
              ) { progress, error in
                if let error {
                  Logger.media.error("Error: \(#function): \(error.localizedDescription)")
                  return
                }
                if let progress {
                  if progress > 99.9 {
                    self.showDownloadMediaToast = false
                  }
                  self.downloadMediaEndPoint = "[GoPro " + camera
                    .serialNumber + "] " + (mediaEndPoint.split(separator: "/").last ?? "")
                  self.downloadProgress = progress
                }
              }
          }
        }
      }
    }
  }

  func removeAllMedia(_ cameraList: [any Camera]) {
    CameraManager.instance.removeAllMediaFromAllCamera(cameraList)
    self.showRemoveMediaToast.toggle()
  }
}
