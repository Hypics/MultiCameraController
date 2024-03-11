//
//  GoProSetting.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension GoPro {
  func setVideoResolution(videoResolution: CameraVideoResolution, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Video Resolution: \(videoResolution.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: videoResolution.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setFps(fps: CameraFps, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set FPS: \(fps.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: fps.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setAutoPowerDown(autoPowerDown: CameraAutoPowerDown, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Auto Power Down: \(autoPowerDown.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: autoPowerDown.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setVideoAspectRatio(videoAspectRatio: CameraVideoAspectRatio, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Video Aspect Ratio: \(videoAspectRatio.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: videoAspectRatio.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setDigitalLenses(digitalLenses: CameraDigitalLenses, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Digital Lenses: \(digitalLenses.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: digitalLenses.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }

  }

  func setAntiFlicker(antiFlicker: CameraAntiFlicker, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Anti Flicker: \(antiFlicker.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: antiFlicker.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setHypersmooth(hypersmooth: CameraHypersmooth, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Hypersmooth: \(hypersmooth.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: hypersmooth.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setHindsight(hindsight: CameraHindsight, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Hindsight: \(hindsight.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: hindsight.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setControlMode(controlMode: CameraControlMode, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Control Mode: \(controlMode.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: controlMode.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setWirelessBand(wirelessBand: CameraWirelessBand, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Wireless Band: \(wirelessBand.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: wirelessBand.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setVideoBitRate(videoBitRate: CameraVideoBitRate, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Video Bit Rate: \(videoBitRate.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: videoBitRate.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func setVideoBitDepth(videoBitDepth: CameraVideoBitDepth, _ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.setting.info("Set Video Bit Depth: \(videoBitDepth.toString()): \(self.cameraName)")
    self.requestUsbSetting(setting: videoBitDepth.toGoProSetting()) { error in
      if let error {
        Logger.setting.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.setting
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }
}
