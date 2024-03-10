//
//  MultiCameraViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class MultiCameraViewModel: ObservableObject {
  @Published var downloadMediaEndPoint: String = ""
  @Published var downloadProgress: Double = 0.0

  @Published var showCameraToast = false
  @Published var showShutterOnToast = false
  @Published var showShutterOffToast = false
  @Published var showDownloadMediaToast = false
  @Published var showRemoveMediaToast = false
  @Published var showRefreshCameraListToast = false
  @Published var showCameraConnectedToast = false
  @Published var showCameraEmptyToast = false

  func getCreationTimestamp(completion: @escaping (Int) -> Void) {
    var creationTimestamp = 2_147_483_647
    for (index, camera) in CameraManager.instance.getConnectedCameraContainer().enumerated() {
      camera.requestUsbMediaList { _, latestCreationTimestamp, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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
    os_log("Remove %@", type: .info, CameraManager.instance.cameraContainer[offsets[offsets.startIndex]].cameraName)
    CameraManager.instance.removeCamera(at: offsets)
    UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
  }

  func downloadMediaAll(_ cameraList: [any Camera]) {
    os_log("Download Media All", type: .info)
    self.getCreationTimestamp { creationTimestamp in
      let creationDate = Date(timeIntervalSince1970: TimeInterval(creationTimestamp))
      let creationDateString = creationDate.toString(CustomDateFormat.simpleYearToSecond.rawValue)

      os_log("creationTimestamp: %@ from %@", type: .info, creationDateString, creationTimestamp.description)
      for camera in cameraList.filter({ $0.isConnected == true }) {
        os_log("Download media list: %@", type: .info, camera.cameraName)
        camera.requestUsbMediaList { mediaEndPointList, _, error in
          if let error {
            os_log("Error: %@", type: .error, error.localizedDescription)
            return
          }

          for mediaEndPoint in mediaEndPointList ?? [] {
            self.showDownloadMediaToast = true
            camera
              .requestUsbMediaDownload(
                mediaEndPoint: mediaEndPoint,
                timestamp_path: creationDateString
              ) { progress, error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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
