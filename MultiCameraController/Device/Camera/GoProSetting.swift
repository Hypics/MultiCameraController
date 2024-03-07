//
//  GoProSetting.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension GoPro {
  func setVideoResolution(videoResolution: CameraVideoResolution, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Video Resolution: %@: %@", type: .info, videoResolution.toString(), self.cameraName)
    self.requestUsbSetting(setting: videoResolution.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setFps(fps: CameraFps, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set FPS: %@: %@", type: .info, fps.toString(), self.cameraName)
    self.requestUsbSetting(setting: fps.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setAutoPowerDown(autoPowerDown: CameraAutoPowerDown, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Auto Power Down: %@: %@", type: .info, autoPowerDown.toString(), self.cameraName)
    self.requestUsbSetting(setting: autoPowerDown.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setVideoAspectRatio(videoAspectRatio: CameraVideoAspectRatio, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Video Aspect Ratio: %@: %@", type: .info, videoAspectRatio.toString(), self.cameraName)
    self.requestUsbSetting(setting: videoAspectRatio.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setDigitalLenses(digitalLenses: CameraDigitalLenses, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Digital Lenses: %@: %@", type: .info, digitalLenses.toString(), self.cameraName)
    self.requestUsbSetting(setting: digitalLenses.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }

  }

  func setAntiFlicker(antiFlicker: CameraAntiFlicker, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Anti Flicker: %@: %@", type: .info, antiFlicker.toString(), self.cameraName)
    self.requestUsbSetting(setting: antiFlicker.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setHypersmooth(hypersmooth: CameraHypersmooth, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Hypersmooth: %@: %@", type: .info, hypersmooth.toString(), self.cameraName)
    self.requestUsbSetting(setting: hypersmooth.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setHindsight(hindsight: CameraHindsight, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Hindsight: %@: %@", type: .info, hindsight.toString(), self.cameraName)
    self.requestUsbSetting(setting: hindsight.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setControlMode(controlMode: CameraControlMode, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Control Mode: %@: %@", type: .info, controlMode.toString(), self.cameraName)
    self.requestUsbSetting(setting: controlMode.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setWirelessBand(wirelessBand: CameraWirelessBand, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Wireless Band: %@: %@", type: .info, wirelessBand.toString(), self.cameraName)
    self.requestUsbSetting(setting: wirelessBand.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setVideoBitRate(videoBitRate: CameraVideoBitRate, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Video Bit Rate: %@: %@", type: .info, videoBitRate.toString(), self.cameraName)
    self.requestUsbSetting(setting: videoBitRate.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }

  func setVideoBitDepth(videoBitDepth: CameraVideoBitDepth, _ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Set Video Bit Depth: %@: %@", type: .info, videoBitDepth.toString(), self.cameraName)
    self.requestUsbSetting(setting: videoBitDepth.toGoProSetting()) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion?(.success(true))
      }
    }
  }
}
