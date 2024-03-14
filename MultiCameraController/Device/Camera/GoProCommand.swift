//
//  GoProCommand.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension GoPro {
  func startShoot(_ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Shutter On: \(self.cameraName)")
    self.requestUsbCommand(command: .shutterOn) { error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.camera
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func stopShoot(_ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Shutter Off: \(self.cameraName)")
    self.requestUsbCommand(command: .shutterOff) { error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.camera
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func enableWiredUsbControl(_: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Enable Wired USB Control: \(self.cameraName)")
    self.requestUsbCommand(command: .enableWiredUsbControl) { error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        return
      }
    }
  }

  func checkConnection(_ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Get camera info: \(self.cameraName)")
    self.requestUsbCameraInfo { goProInfo, error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        self.isConnected = false
        self.goProInfo = nil
        completion?(.failure(error))
      } else {
        Logger.camera
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        self.isConnected = true
        self.goProInfo = goProInfo
        completion?(.success(true))
      }
    }
  }

  func startPreview(_ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Start Preview: \(self.cameraName)")
    self.requestUsbCommand(command: .startPreview) { error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.camera
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }

  func stopPreview(_ completion: ((Result<Bool, Error>) -> Void)?) {
    Logger.camera.info("Stop Preview: \(self.cameraName)")
    self.requestUsbCommand(command: .stopPreview) { error in
      if let error {
        Logger.camera.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
      } else {
        Logger.camera
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion?(.success(true))
      }
    }
  }
}
