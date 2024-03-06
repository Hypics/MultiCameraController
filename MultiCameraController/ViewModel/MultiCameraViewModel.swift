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
  @Published var downloadMediaUrl: String = ""
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

  func getConnectedCameraList() -> [any Camera] {
    CameraManager.instance.cameraContainer.filter { $0.isConnected == true }
  }

  func getCreationTimestamp(completion: @escaping (Int) -> Void) {
    var creationTimestamp = 2_147_483_647
    for (index, camera) in self.getConnectedCameraList().enumerated() {
      camera.requestUsbMediaList { _, latestCreationTimestamp, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        creationTimestamp = min(creationTimestamp, latestCreationTimestamp)

        if index == self.getConnectedCameraList().count - 1 {
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
      for camera in self.getConnectedCameraList() {
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
                  self.downloadMediaUrl = "[GoPro " + camera
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
    for camera in self.getConnectedCameraList() {
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

  func setVideoResolution4K() {
    os_log("Video Resolution: 4K, 16:9", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .videoResolution_4k_16_9) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showVideoResolutionToast.toggle()
  }

  func setVideoFps120Hz() {
    os_log("Video FPS: 120Hz", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .fps_120) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showVideoFpsToast.toggle()
  }

  func setVideoDigitalLensLinear() {
    os_log("Video Digital Lens: Linear", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .videoDigitalLenses_linear) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showVideoDigitalLensToast.toggle()
  }

  func setAntiFlicker60Hz() {
    os_log("Anti Flicker: 60Hz", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .antiFlicker_60) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showAntiFlickerToast.toggle()
  }

  func setHyperSmoothOff() {
    os_log("Hypersmooth: Off", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .hypersmooth_off) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showHypersmoothToast.toggle()
  }

  func setHindsightOff() {
    os_log("Hindsight: Off", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .hindsight_off) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showHindsightToast.toggle()
  }

  func setVideoBitRateHigh() {
    os_log("System Video Bit Rate: High", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .systemVideoBitRate_high) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showSystemVideoBitRateToast.toggle()
  }

  func setVideoBitDepth10bit() {
    os_log("System Video Bit Depth: 10bit", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .systemVideoBitDepth_10bit) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showSystemVideoBitDepthToast.toggle()
  }

  func setAutoPowerDownNever() {
    os_log("Auto Power Down: Never", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .autoPowerDown_never) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showAutoPowerDownToast.toggle()
  }

  func setControlsModePro() {
    os_log("Controls Mode: Pro", type: .info)
    for camera in self.getConnectedCameraList() {
      camera.requestUsbSetting(setting: .controls_pro) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showControlsModeToast.toggle()
  }
}
