//
//  Camera.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation

protocol Camera: Hashable {
  var serialNumber: String { get set }
  var isConnected: Bool { get set }

  func startShoot(_ completion: @escaping (Result<Bool, Error>) -> Void)
  func stopShoot(_ completion: @escaping (Result<Bool, Error>) -> Void)

  func checkConnection(_ completion: @escaping (Result<Bool, Error>) -> Void)

  func downloadMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>, Double?) -> Void)
  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, Double?) -> Void)

  func removeMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>) -> Void)
  func removeAllMedia(_ completion: @escaping (Result<Bool, Error>) -> Void)

  // TODO: remove
  func requestUsbCommand(command: GoProUsbCommand, _ completion: ((Error?) -> Void)?)
  func requestUsbSetting(setting: GoProUsbSetting, _ completion: ((Error?) -> Void)?)
  func requestUsbCameraInfo(_ completion: ((GoProInfo?, Error?) -> Void)?)
  func requestUsbMediaList(_ completion: (([String]?, Int, Error?) -> Void)?)
  func requestUsbMediaDownload(
    mediaEndPoint: String,
    timestamp_path: String?,
    _ completion: @escaping (Double?, Error?) -> Void
  )
  func requestUsbMediaRemove(mediaEndPoint: String, _ completion: ((Error?) -> Void)?)
}
