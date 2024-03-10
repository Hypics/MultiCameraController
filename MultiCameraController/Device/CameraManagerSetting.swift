//
//  CameraManagerSetting.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension CameraManager {
  func setVideoResolutionAll(_ videoResolution: CameraVideoResolution, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Video Resolution: %@ (%@/%@)",
        type: .info,
        videoResolution.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setVideoResolution(videoResolution: videoResolution) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setFpsAll(_ fps: CameraFps, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set FPS: %@ (%@/%@)",
        type: .info,
        fps.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setFps(fps: fps) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setAutoPowerDownAll(_ autoPowerDown: CameraAutoPowerDown, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Auto Power Down: %@ (%@/%@)",
        type: .info,
        autoPowerDown.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setAutoPowerDown(autoPowerDown: autoPowerDown) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setVideoAspectRatioAll(_ videoAspectRatio: CameraVideoAspectRatio, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Video Aspect Ratio: %@ (%@/%@)",
        type: .info,
        videoAspectRatio.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setVideoAspectRatio(videoAspectRatio: videoAspectRatio) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setDigitalLensesAll(_ digitalLenses: CameraDigitalLenses, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Digital Lenses: %@ (%@/%@)",
        type: .info,
        digitalLenses.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setDigitalLenses(digitalLenses: digitalLenses) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setAntiFlickerAll(_ antiFlicker: CameraAntiFlicker, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Anti Flicker: %@ (%@/%@)",
        type: .info,
        antiFlicker.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setAntiFlicker(antiFlicker: antiFlicker) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setHypersmoothAll(_ hypersmooth: CameraHypersmooth, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Hypersmooth: %@ (%@/%@)",
        type: .info,
        hypersmooth.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setHypersmooth(hypersmooth: hypersmooth) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setHindsightAll(_ hindsight: CameraHindsight, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Hindsight: %@ (%@/%@)",
        type: .info,
        hindsight.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setHindsight(hindsight: hindsight) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setControlModeAll(_ controlMode: CameraControlMode, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Control Mode: %@ (%@/%@)",
        type: .info,
        controlMode.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setControlMode(controlMode: controlMode) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setWirelessBandAll(_ wirelessBand: CameraWirelessBand, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Wireless Band: %@ (%@/%@)",
        type: .info,
        wirelessBand.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setWirelessBand(wirelessBand: wirelessBand) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setVideoBitRateAll(_ videoBitRate: CameraVideoBitRate, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Video Bit Rate: %@ (%@/%@)",
        type: .info,
        videoBitRate.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setVideoBitRate(videoBitRate: videoBitRate) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

  func setVideoBitDepthAll(_ videoBitDepth: CameraVideoBitDepth, _ cameraList: [any Camera]?) {
    for (index, camera) in (cameraList ?? self.cameraContainer).filter({ $0.isConnected == true }).enumerated() {
      os_log(
        "Set Video Bit Depth: %@ (%@/%@)",
        type: .info,
        videoBitDepth.toString(),
        index + 1,
        self.cameraContainer.count
      )
      camera.setVideoBitDepth(videoBitDepth: videoBitDepth) { result in
        switch result {
        case let .success(response):
          os_log("Success: %@: %@", type: .info, #function, response)

        case let .failure(error):
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        }
      }
    }
  }

}
