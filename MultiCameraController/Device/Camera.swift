//
//  Camera.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation

protocol Camera: Hashable {
  var serialNumber: String { get set }
  var cameraName: String { get set }
  var isConnected: Bool { get set }
  var mediaUrlStringList: [String] { get set }

  func setCameraInfo(cameraInfo: CameraInfo)
  func getCameraInfo() -> CameraInfo?

  func startShoot(_ completion: ((Result<Bool, Error>) -> Void)?)
  func stopShoot(_ completion: ((Result<Bool, Error>) -> Void)?)

  func checkConnection(_ completion: ((Result<Bool, Error>) -> Void)?)
  func enableWiredUsbControl(_ completion: ((Result<Bool, Error>) -> Void)?)

  func updateMediaUrlStringList(_ completion: ((Result<Bool, Error>, [String]?) -> Void)?)

  func downloadMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>, Double?) -> Void)
  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, String?, Double?) -> Void)

  func removeMedia(mediaUrl: String, _ completion: @escaping (Result<Bool, Error>) -> Void)
  func removeMedia(at offsets: IndexSet)
  func removeAllMedia(_ completion: ((Result<Bool, Error>) -> Void)?)

  // TODO: remove
  func requestUsbSetting(setting: GoProUsbSetting, _ completion: ((Error?) -> Void)?)
  func requestUsbMediaList(_ completion: (([String]?, Int, Error?) -> Void)?)
  func requestUsbMediaDownload(
    mediaEndPoint: String,
    timestamp_path: String?,
    _ completion: @escaping (Double?, Error?) -> Void
  )
}
