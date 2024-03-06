//
//  GoPro.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/18/23.
//

import Alamofire
import Foundation
import os.log

class GoPro: Camera {
  var serialNumber: String
  var isConnected: Bool

  var goProInfo: GoProInfo?

  let url: String
  let timeoutInterval: Double = 3.0

  init(serialNumber: String) {
    self.serialNumber = serialNumber
    self.isConnected = false
    if serialNumber.isEmpty {
      self.url = ""
      return
    }

    let serialNumberX = serialNumber.substring(with: 0 ..< 1)
    let serialNumberYZ = serialNumber.substring(with: 1 ..< 3)
    self.url = "http://172.2" + serialNumberX + ".1" + serialNumberYZ + ".51:8080"
  }

  static func == (lhs: GoPro, rhs: GoPro) -> Bool {
    return lhs.serialNumber == rhs.serialNumber
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.serialNumber)
  }

  func startShoot(_ completion: @escaping (Result<Bool, Error>) -> Void) {
    os_log("Shutter On", type: .info)
    self.requestUsbCommand(command: .shutterOn) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion(.success(true))
      }
    }
  }

  func stopShoot(_ completion: @escaping (Result<Bool, Error>) -> Void) {
    os_log("Shutter Off", type: .info)
    self.requestUsbCommand(command: .shutterOff) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion(.success(true))
      }
    }
  }

  func checkConnection(_ completion: @escaping (Result<Bool, Error>) -> Void) {
    os_log("Get camera info: GoPro %@", type: .info, self.serialNumber)
    self.requestUsbCameraInfo { goProInfo, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        self.isConnected = false
        self.goProInfo = nil
        completion(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        self.isConnected = true
        self.goProInfo = goProInfo
        completion(.success(true))
      }
    }
  }

  func downloadMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>, Double?) -> Void) {
    os_log("Download Media: %@", type: .info, mediaUrl)
    self.requestUsbMediaDownload(mediaEndPoint: mediaUrl, timestamp_path: nil) { progress, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error), nil)
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion(.success(true), progress)
      }
    }
  }

  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, Double?) -> Void) {
    os_log("Download media list: GoPro %@", type: .info, self.serialNumber)
    self.requestUsbMediaList { mediaEndPointList, _, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error), nil)
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        guard let mediaEndPointList else { return }
        for (index, mediaUrl) in mediaEndPointList.enumerated() {
          os_log("Download Media (%@/%@: %@", type: .info, index + 1, mediaEndPointList.count, mediaUrl)
          self.requestUsbMediaDownload(mediaEndPoint: mediaUrl, timestamp_path: nil) { progress, error in
            if let error {
              os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
              completion(.failure(error), nil)
            } else {
              os_log(
                "Success: %@: %@",
                type: .info,
                #function,
                Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
              )
              completion(.success(true), progress)
            }
          }
        }
      }
    }
  }

  func removeMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    os_log("Remove Media: %@", type: .info, mediaUrl)
    self.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        completion(.success(true))
      }
    }
  }

  func removeAllMedia(_ completion: @escaping (Result<Bool, Error>) -> Void) {
    os_log("Remove media list: GoPro %@", type: .info, self.serialNumber)
    self.requestUsbMediaList { mediaEndPointList, _, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error))
      } else {
        os_log(
          "Success: %@: %@",
          type: .info,
          #function,
          Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
        )
        guard let mediaEndPointList else { return }
        for (index, mediaUrl) in mediaEndPointList.enumerated() {
          os_log("Download Media (%@/%@: %@", type: .info, index + 1, mediaEndPointList.count, mediaUrl)
          self.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
            if let error {
              os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
              completion(.failure(error))
            } else {
              os_log(
                "Success: %@: %@",
                type: .info,
                #function,
                Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
              )
              completion(.success(true))
            }
          }
        }
      }
    }
  }

  func requestUsbCommand(command: GoProUsbCommand, _ completion: ((Error?) -> Void)?) {
    let commandUrl = self.url + command.endPoint
    AF.request(
      commandUrl,
      method: .get,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: ["Content-Type": "application/json", "Accept": "application/json"]
    ) {
      $0.timeoutInterval = self.timeoutInterval
    }
    .validate(statusCode: 200 ..< 300)
    .responseJSON { response in
      switch response.result {
      case .success:
        os_log("success url: %@", type: .debug, commandUrl)
        completion?(nil)

      case let .failure(error):
        os_log("error: %@", type: .error, error.localizedDescription)
        completion?(error)
      }
    }
  }

  func requestUsbSetting(setting: GoProUsbSetting, _ completion: ((Error?) -> Void)?) {
    let settingUrl = self.url + setting.endPoint
    AF.request(
      settingUrl,
      method: .get,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: ["Content-Type": "application/json", "Accept": "application/json"]
    ) {
      $0.timeoutInterval = self.timeoutInterval
    }
    .validate(statusCode: 200 ..< 300)
    .responseJSON { response in
      switch response.result {
      case .success:
        os_log("success url: %@", type: .debug, settingUrl)
        completion?(nil)

      case let .failure(error):
        os_log("error: %@", type: .error, error.localizedDescription)
        completion?(error)
      }
    }
  }

  func requestUsbCameraInfo(_ completion: ((GoProInfo?, Error?) -> Void)?) {
    let commandUrl = self.url + GoProUsbCommand.getHardwareInfo.endPoint
    os_log("url: %@", type: .info, commandUrl)

    AF.request(
      commandUrl,
      method: .get,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: ["Content-Type": "application/json", "Accept": "application/json"]
    ) {
      $0.timeoutInterval = self.timeoutInterval
    }
    .validate(statusCode: 200 ..< 300)
    .responseJSON { response in
      switch response.result {
      case let .success(obj):
        do {
          let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
          let cameraInfoJson = try JSONDecoder().decode(GoProInfo.self, from: dataJSON)
          completion?(cameraInfoJson, nil)
        } catch {
          os_log("error: %@", type: .error, error.localizedDescription)
          completion?(nil, error)
        }

      case let .failure(error):
        os_log("error: %@", type: .error, error.localizedDescription)
        completion?(nil, error)
      }
    }
  }

  func requestUsbMediaList(_ completion: (([String]?, Int, Error?) -> Void)?) {
    let commandUrl = self.url + GoProUsbCommand.getMediaList.endPoint
    os_log("url: %@", type: .info, commandUrl)

    AF.request(
      commandUrl,
      method: .get,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: ["Content-Type": "application/json", "Accept": "application/json"]
    ) {
      $0.timeoutInterval = self.timeoutInterval
    }
    .validate(statusCode: 200 ..< 300)
    .responseJSON { response in
      switch response.result {
      case let .success(obj):
        var mediaEndPointList: [String] = []
        do {
          let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
          let mediaListJson = try JSONDecoder().decode(MediaListInfo.self, from: dataJSON)

          var latestCreationTimestamp = 0
          for mediaInfo in mediaListJson.media {
            for fileInfo in mediaInfo.fs {
              mediaEndPointList.append("/videos/DCIM/" + mediaInfo.d + "/" + fileInfo.n)
              latestCreationTimestamp = max(latestCreationTimestamp, Int(fileInfo.cre) ?? latestCreationTimestamp)
            }
          }
          os_log("mediaList: %@", type: .info, mediaEndPointList.description)
          os_log("creationTimestamp: %@", type: .info, latestCreationTimestamp.description)
          completion?(mediaEndPointList, latestCreationTimestamp, nil)
        } catch {
          os_log("error: %@", type: .error, error.localizedDescription)
          completion?(nil, 0, error)
        }

      case let .failure(error):
        os_log("error: %@", type: .error, error.localizedDescription)
        completion?(nil, 0, error)
      }
    }
  }

  func requestUsbMediaDownload(
    mediaEndPoint: String,
    timestamp_path: String?,
    _ completion: @escaping (Double?, Error?) -> Void
  ) {
    let fileManager = FileManager.default
    let appUrl: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileName: String = URL(string: mediaEndPoint)?.lastPathComponent ?? ""
    var fileUrl: URL = if let timestamp_path {
      appUrl.appendingPathComponent(timestamp_path).appendingPathComponent(self.serialNumber + "_" + fileName)
    } else {
      appUrl.appendingPathComponent(self.serialNumber + "_" + fileName)
    }
    let destination: DownloadRequest.Destination = { _, _ in
      (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
    }

    let mediaUrl: String = self.url + mediaEndPoint
    os_log("mediaUrl: %@", type: .info, mediaUrl)
    os_log("fileUrl: %@", type: .info, fileUrl.path())
    AF.download(mediaUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination)
      .downloadProgress { progress in
        completion(Double(progress.fractionCompleted * 100), nil)
      }
      .response { response in
        if response.error != nil {
          os_log("Download failed: %@", type: .error, response.error?.errorDescription ?? "")
          completion(nil, nil)
        } else {
          os_log("Download Success: %@", type: .info, mediaUrl)
        }
      }
  }

  func requestUsbMediaRemove(mediaEndPoint: String, _ completion: ((Error?) -> Void)?) {
    let mediaUrl = self.url + mediaEndPoint
    AF.request(
      mediaUrl,
      method: .delete,
      parameters: nil,
      encoding: URLEncoding.default,
      headers: ["Content-Type": "application/json", "Accept": "application/json"]
    ) {
      $0.timeoutInterval = self.timeoutInterval
    }
    .validate(statusCode: 200 ..< 300)
    .responseJSON { response in
      if response.error != nil {
        os_log("Remove failed: %@", type: .error, response.error?.errorDescription ?? "")
        completion?(nil)
      } else {
        os_log("Remove Success: %@", type: .info, mediaUrl)
      }
    }
  }
}
