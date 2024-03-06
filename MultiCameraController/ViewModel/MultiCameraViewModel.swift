//
//  MultiCameraViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class MultiCameraViewModel: ObservableObject {
  @Published var goProSerialNumberList =
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  @Published var cameraConnectionInfoList: [CameraConnectionInfo] =
    (
      UserDefaults.standard
        .array(forKey: "GoProSerialNumberList") as? [String] ?? []
    )
    .reduce([CameraConnectionInfo]()) { result, item in
      var temp = result
      temp.append(CameraConnectionInfo(camera: GoPro(serialNumber: item)))
      return temp
    }

  @Published var showSettingView = false
  @Published var showCameraView = false

  @Published var cameraConnectionInfoListEditable = false
  @Published var targetCameraConnectionInfo = CameraConnectionInfo(camera: GoPro(serialNumber: ""))
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

  func getConnectedCameraList() -> [CameraConnectionInfo] {
    self.cameraConnectionInfoList.filter { $0.isConnected == true }
  }

  func getCreationTimestamp(completion: @escaping (Int) -> Void) {
    var creationTimestamp = 2_147_483_647
    for cameraConnectionInfo in self.getConnectedCameraList() {
      cameraConnectionInfo.camera.requestUsbMediaList { _, latestCreationTimestamp, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        creationTimestamp = min(creationTimestamp, latestCreationTimestamp)

        if cameraConnectionInfo == self.cameraConnectionInfoList.last {
          completion(creationTimestamp)
        }
      }
    }
  }

  func registerCamera(newCameraSerialNumber: String) {
    if self.newCameraSerialNumber.count == 3, self.newCameraSerialNumber.isInt(),
       !self.cameraConnectionInfoList.contains(where: { $0.camera.serialNumber == newCameraSerialNumber })
    {
      os_log("Add GoPro %@", type: .info, self.newCameraSerialNumber)
      self.goProSerialNumberList.append(self.newCameraSerialNumber)
      self.cameraConnectionInfoList
        .append(CameraConnectionInfo(camera: GoPro(serialNumber: self.newCameraSerialNumber)))

      let index = self.cameraConnectionInfoList.count - 1
      os_log(
        "Enable Wired USB Control: GoPro %@",
        type: .info,
        self.cameraConnectionInfoList[index].camera.serialNumber
      )
      self.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          if index >= self.cameraConnectionInfoList.count {
            return
          }
          self.cameraConnectionInfoList[index].isConnected = false
          return
        }

        if index >= self.cameraConnectionInfoList.count {
          return
        }
        self.cameraConnectionInfoList[index].isConnected = true
        self.cameraConnectionInfoList[index].camera
          .requestUsbCommand(command: .enableWiredUsbControl) { error in
            if error != nil {
              os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
              return
            }
          }
      }
    } else {
      os_log("%@ is not a serial number (3 digits)", type: .error, self.newCameraSerialNumber)
    }
  }

  func deleteCameraItem(at offsets: IndexSet) {
    os_log(
      "Remove GoPro %@",
      type: .info,
      self.cameraConnectionInfoList[offsets[offsets.startIndex]].camera.serialNumber
    )
    self.goProSerialNumberList.remove(atOffsets: offsets)
    self.cameraConnectionInfoList.remove(atOffsets: offsets)
  }

  func connectCameraItem(index: Int, showToast: Bool = false) {
    os_log("Connect GoPro %@", type: .info, self.cameraConnectionInfoList[index].camera.serialNumber)
    self.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        self.cameraConnectionInfoList[index].isConnected = false
        if showToast {
          self.showCameraEmptyToast.toggle()
        }
        return
      }
      self.cameraConnectionInfoList[index].isConnected = true
      if showToast {
        self.showCameraConnectedToast.toggle()
      }

      os_log(
        "Enable Wired USB Control: GoPro %@",
        type: .info,
        self.cameraConnectionInfoList[index].camera.serialNumber
      )
      self.cameraConnectionInfoList[index].camera.requestUsbCommand(command: .enableWiredUsbControl) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
  }

  func startShootingAll() {
    os_log("Shutter On All", type: .info)
    for cameraConnectionInfo in self.getConnectedCameraList() {
      cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOn) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showShutterOnToast.toggle()
  }

  func stopShootingAll() {
    os_log("Shutter Off All", type: .info)
    for cameraConnectionInfo in self.getConnectedCameraList() {
      cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOff) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showShutterOffToast.toggle()
  }

  func downloadMediaAll() {
    os_log("Download Media All", type: .info)
    self.getCreationTimestamp { creationTimestamp in
      let creationDate = Date(timeIntervalSince1970: TimeInterval(creationTimestamp))
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "YYMMdd_hhmmss"
      let creationDateString = dateFormatter.string(from: creationDate)
      os_log("creationTimestamp: %@ from %@", type: .info, creationDateString, creationTimestamp.description)
      for cameraConnectionInfo in self.getConnectedCameraList() {
        os_log(
          "Download media list: GoPro %@",
          type: .info,
          cameraConnectionInfo.camera.serialNumber
        )
        cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, _, error in
          if error != nil {
            os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
            return
          }

          for mediaEndPoint in mediaEndPointList ?? [] {
            self.showDownloadMediaToast = true
            cameraConnectionInfo.camera
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
                  self.downloadMediaUrl = "[GoPro " + cameraConnectionInfo.camera
                    .serialNumber + "] " + (mediaEndPoint.split(separator: "/").last ?? "")
                  self.downloadProgress = progress
                }
              }
          }
        }
      }
    }
  }

  func removeMediaAll() {
    os_log("Remove Media All", type: .info)
    for cameraConnectionInfo in self.getConnectedCameraList() {
      os_log("Remove media list: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
      cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, _, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }

        for mediaUrl in mediaEndPointList ?? [] {
          cameraConnectionInfo.camera
            .requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
        }
      }
    }
    self.showRemoveMediaToast.toggle()
  }

  func applyPreset1() {
    os_log("4K@120FPS, 16:9, Linear, 60Hz, Off, High, 10bit, Never, Pro", type: .info)
    for cameraConnectionInfo in self.getConnectedCameraList() {
      for presetSetting in GoProUsbSettingPreset.mounted_4k_120fps.settings {
        cameraConnectionInfo.camera.requestUsbSetting(setting: presetSetting) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .videoResolution_4k_16_9) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .fps_120) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .videoDigitalLenses_linear) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .antiFlicker_60) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .hypersmooth_off) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .hindsight_off) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .systemVideoBitRate_high) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .systemVideoBitDepth_10bit) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .autoPowerDown_never) { error in
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
    for cameraConnectionInfo in self.cameraConnectionInfoList {
      cameraConnectionInfo.camera.requestUsbSetting(setting: .controls_pro) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
      }
    }
    self.showControlsModeToast.toggle()
  }
}
