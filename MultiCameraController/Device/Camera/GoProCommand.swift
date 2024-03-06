//
//  GoProCommand.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension GoPro {
  func startShoot(_ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Shutter On", type: .info)
    self.requestUsbCommand(command: .shutterOn) { error in
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

  func stopShoot(_ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Shutter Off", type: .info)
    self.requestUsbCommand(command: .shutterOff) { error in
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

  func enableWiredUsbControl(_: ((Result<Bool, Error>) -> Void)?) {
    os_log("Enable Wired USB Control: %@", type: .info, self.cameraName)
    self.requestUsbCommand(command: .enableWiredUsbControl) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        return
      }
    }
  }

  func checkConnection(_ completion: ((Result<Bool, Error>) -> Void)?) {
    os_log("Get camera info: %@", type: .info, self.cameraName)
    self.requestUsbCameraInfo { goProInfo, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        self.isConnected = false
        self.goProInfo = nil
        completion?(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        self.isConnected = true
        self.goProInfo = goProInfo
        completion?(.success(true))
      }
    }
  }

  func updateMediaUrlStringList(_ completion: ((Result<Bool, Error>, [String]?) -> Void)?) {
    os_log("Update Media Url String List: %@", type: .info, self.cameraName)
    self.requestUsbMediaList { mediaUrlStringList, _, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error), nil)
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        self.mediaUrlStringList = mediaUrlStringList ?? []
        completion?(.success(true), mediaUrlStringList)
      }
    }
  }
}
