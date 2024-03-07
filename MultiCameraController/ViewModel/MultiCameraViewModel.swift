//
//  MultiCameraViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class MultiCameraViewModel: ObservableObject {
  @Published var showSettingView = false
  @Published var showCameraView = false

  @Published var cameraConnectionInfoListEditable = false
  @Published var targetCamera: any Camera = GoPro(serialNumber: "")
  @Published var newCameraSerialNumber: String = ""
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

  @Published var showPreset1Toast = false
  @Published var showVideoResolutionToast = false
  @Published var showVideoFpsToast = false
  @Published var showVideoDigitalLensToast = false
  @Published var showAntiFlickerToast = false
  @Published var showHypersmoothToast = false
  @Published var showHindsightToast = false
  @Published var showSystemVideoBitRateToast = false
  @Published var showSystemVideoBitDepthToast = false
  @Published var showAutoPowerDownToast = false
  @Published var showControlsModeToast = false

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
  }

  func downloadMediaAll() {
    os_log("Download Media All", type: .info)
    self.getCreationTimestamp { creationTimestamp in
      let creationDate = Date(timeIntervalSince1970: TimeInterval(creationTimestamp))
      let creationDateString = creationDate.toString(CustomDateFormat.simpleYearToSecond.rawValue)

      os_log("creationTimestamp: %@ from %@", type: .info, creationDateString, creationTimestamp.description)
      for camera in CameraManager.instance.getConnectedCameraContainer() {
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

  func removeAllMedia() {
    CameraManager.instance.removeAllMediaFromAllCamera()
    self.showRemoveMediaToast.toggle()
  }

  func applyPreset1() {
    os_log("4K@120FPS, 16:9, Linear, 60Hz, Off, High, 10bit, Never, Pro", type: .info)
    for camera in CameraManager.instance.getConnectedCameraContainer() {
      for presetSetting in GoProUsbSettingPreset.mounted_4k_120fps.settings {
        camera.requestUsbSetting(setting: presetSetting) { error in
          if error != nil {
            os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
            return
          }
        }
      }
    }
    self.showPreset1Toast.toggle()
  }

  func setVideoResolution(_ videoResolution: CameraVideoResolution) {
    CameraManager.instance.setVideoResolutionAll(videoResolution)
    self.showVideoResolutionToast.toggle()
  }

  func setFps(_ fps: CameraFps) {
    CameraManager.instance.setFpsAll(fps)
    self.showVideoFpsToast.toggle()
  }

  func setVideoDigitalLens(_ digitalLenses: CameraDigitalLenses) {
    CameraManager.instance.setDigitalLensesAll(digitalLenses)
    self.showVideoDigitalLensToast.toggle()
  }

  func setAntiFlicker(_ antiFlicker: CameraAntiFlicker) {
    CameraManager.instance.setAntiFlickerAll(antiFlicker)
    self.showAntiFlickerToast.toggle()
  }

  func setHypersmooth(_ hypersmooth: CameraHypersmooth) {
    CameraManager.instance.setHypersmoothAll(hypersmooth)
    self.showHypersmoothToast.toggle()
  }

  func setHindsight(_ hindsight: CameraHindsight) {
    CameraManager.instance.setHindsightAll(hindsight)
    self.showHindsightToast.toggle()
  }

  func setVideoBitRate(_ videoBitRate: CameraVideoBitRate) {
    CameraManager.instance.setVideoBitRateAll(videoBitRate)
    self.showSystemVideoBitRateToast.toggle()
  }

  func setVideoBitDepth(_ videoBitDepth: CameraVideoBitDepth) {
    CameraManager.instance.setVideoBitDepthAll(videoBitDepth)
    self.showSystemVideoBitDepthToast.toggle()
  }

  func setAutoPowerDown(_ autoPowerDown: CameraAutoPowerDown) {
    CameraManager.instance.setAutoPowerDownAll(autoPowerDown)
    self.showAutoPowerDownToast.toggle()
  }

  func setControlsMode(_ controlMode: CameraControlMode) {
    CameraManager.instance.setControlModeAll(controlMode)
    self.showControlsModeToast.toggle()
  }
}
