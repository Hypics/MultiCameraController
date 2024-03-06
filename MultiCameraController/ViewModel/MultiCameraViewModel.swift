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

  @Published var cameraConnectionInfoListEditable = false

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
