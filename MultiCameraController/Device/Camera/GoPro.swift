//
//  GoPro.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/18/23.
//

import Alamofire
import Foundation
import OSLog

class GoPro: Camera {
  static func == (lhs: GoPro, rhs: GoPro) -> Bool {
    lhs.serialNumber == rhs.serialNumber
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.serialNumber)
  }

  var serialNumber: String
  var cameraName: String
  var baseUrl: String
  var isConnected: Bool
  var mediaEndPointList: [String]

  var goProInfo: GoProInfo?

  let url: String
  let timeoutInterval: Double

  init(serialNumber: String) {
    self.serialNumber = serialNumber
    self.cameraName = "GoPro \(self.serialNumber)"
    self.isConnected = false
    self.mediaEndPointList = []
    self.timeoutInterval = 3.0

    if serialNumber.isEmpty {
      self.baseUrl = ""
      self.url = ""
      return
    }

    let serialNumberX = serialNumber.substring(with: 0 ..< 1)
    let serialNumberYZ = serialNumber.substring(with: 1 ..< 3)
    self.baseUrl = "http://172.2\(serialNumberX).1\(serialNumberYZ).51"
    self.url = "\(self.baseUrl):8080"
  }

  func getCameraInfo() -> CameraInfo? {
    self.goProInfo
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
        Logger.camera.debug("Success url: \(commandUrl)")
        completion?(nil)

      case let .failure(error):
        Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
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
        Logger.camera.debug("Success url: \(settingUrl)")
        completion?(nil)

      case let .failure(error):
        Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
        completion?(error)
      }
    }
  }

  func requestUsbCameraInfo(_ completion: ((GoProInfo?, Error?) -> Void)?) {
    let commandUrl = self.url + GoProUsbCommand.getHardwareInfo.endPoint
    Logger.camera.info("url: \(commandUrl)")

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
          Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
          completion?(nil, error)
        }

      case let .failure(error):
        Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
        completion?(nil, error)
      }
    }
  }

  func requestUsbMediaList(_ completion: (([String]?, Int, Error?) -> Void)?) {
    let commandUrl = self.url + GoProUsbCommand.getMediaList.endPoint
    Logger.camera.info("url: \(commandUrl)")

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
          let mediaListJson = try JSONDecoder().decode(GoProMediaListInfo.self, from: dataJSON)

          var latestCreationTimestamp = 0
          for mediaInfo in mediaListJson.media {
            for fileInfo in mediaInfo.fs {
              // TODO: add additional info
              mediaEndPointList.append("/videos/DCIM/" + mediaInfo.d + "/" + fileInfo.n)
              latestCreationTimestamp = max(latestCreationTimestamp, Int(fileInfo.cre) ?? latestCreationTimestamp)
            }
          }
          Logger.camera.info("mediaList: \(mediaEndPointList.description)")
          Logger.camera.info("creationTimestamp: \(latestCreationTimestamp.description)")
          completion?(mediaEndPointList, latestCreationTimestamp, nil)
        } catch {
          Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
          completion?(nil, 0, error)
        }

      case let .failure(error):
        Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
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
    let fileUrl: URL = if let timestamp_path {
      appUrl.appendingPathComponent(timestamp_path).appendingPathComponent(self.serialNumber + "_" + fileName)
    } else {
      appUrl.appendingPathComponent(self.serialNumber + "_" + fileName)
    }
    let destination: DownloadRequest.Destination = { _, _ in
      (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
    }

    let mediaUrl: String = self.url + mediaEndPoint
    Logger.camera.info("mediaUrl: \(mediaUrl)")
    Logger.camera.info("fileUrl: \(fileUrl.path())")
    AF.download(mediaUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination)
      .downloadProgress { progress in
        completion(Double(progress.fractionCompleted * 100), nil)
      }
      .response { response in
        if let error = response.error {
          Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
          completion(nil, nil)
        } else {
          Logger.camera.info("Download Success: \(mediaUrl)")
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
      if let error = response.error {
        Logger.camera.error("Error: \(#function): \(error.localizedDescription)")
        completion?(nil)
      } else {
        Logger.camera.info("Remove Success: \(mediaUrl)")
      }
    }
  }
}
