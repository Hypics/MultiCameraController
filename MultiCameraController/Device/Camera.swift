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
  var mediaEndPointList: [String] { get set }

  func getCameraInfo() -> CameraInfo?

  // TODO: remove
  func requestUsbSetting(setting: GoProUsbSetting, _ completion: ((Error?) -> Void)?)
  func requestUsbMediaList(_ completion: (([String]?, Int, Error?) -> Void)?)
  func requestUsbMediaDownload(
    mediaEndPoint: String,
    timestamp_path: String?,
    _ completion: @escaping (Double?, Error?) -> Void
  )

  // Command
  func startShoot(_ completion: ((Result<Bool, Error>) -> Void)?)
  func stopShoot(_ completion: ((Result<Bool, Error>) -> Void)?)

  func checkConnection(_ completion: ((Result<Bool, Error>) -> Void)?)
  func enableWiredUsbControl(_ completion: ((Result<Bool, Error>) -> Void)?)

  // Media
  func updateMediaEndPointList(_ completion: ((Result<Bool, Error>, [String]?) -> Void)?)

  func downloadMedia(mediaEndPoint: String, _ completion: @escaping (Result<Bool, Error>, Double?) -> Void)
  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, String?, Double?) -> Void)

  func removeMedia(at offsets: IndexSet)
  func removeMedia(mediaEndPoint: String, _ completion: @escaping (Result<Bool, Error>) -> Void)
  func removeAllMedia(_ completion: ((Result<Bool, Error>) -> Void)?)

  // Setting
  func setVideoResolution(videoResolution: CameraVideoResolution, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setFps(fps: CameraFps, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setAutoPowerDown(autoPowerDown: CameraAutoPowerDown, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setVideoAspectRatio(videoAspectRatio: CameraVideoAspectRatio, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setDigitalLenses(digitalLenses: CameraDigitalLenses, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setAntiFlicker(antiFlicker: CameraAntiFlicker, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setHypersmooth(hypersmooth: CameraHypersmooth, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setHindsight(hindsight: CameraHindsight, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setControlMode(controlMode: CameraControlMode, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setWirelessBand(wirelessBand: CameraWirelessBand, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setVideoBitRate(videoBitRate: CameraVideoBitRate, _ completion: ((Result<Bool, Error>) -> Void)?)
  func setVideoBitDepth(videoBitDepth: CameraVideoBitDepth, _ completion: ((Result<Bool, Error>) -> Void)?)
}
