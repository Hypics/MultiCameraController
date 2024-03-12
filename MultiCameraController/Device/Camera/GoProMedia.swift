//
//  GoProMedia.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import OSLog

extension GoPro {
  func updateMediaEndPointList(_ completion: ((Result<Bool, Error>, [String]?) -> Void)?) {
    Logger.media.info("Update Media EndPoint List: \(self.cameraName)")
    self.requestUsbMediaList { mediaEndPointList, _, error in
      if let error {
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error), nil)
      } else {
        Logger.media
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        self.mediaEndPointList = mediaEndPointList ?? []
        completion?(.success(true), mediaEndPointList)
      }
    }
  }

  func downloadMedia(mediaEndPoint: String, _ completion: @escaping (Result<Bool, Error>, Double?) -> Void) {
    Logger.media.info("Download Media: \(mediaEndPoint)")
    self.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
      if let error {
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        completion(.failure(error), nil)
      } else {
        Logger.media
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
        completion(.success(true), progress)
      }
    }
  }

  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, String?, Double?) -> Void) {
    self.updateMediaEndPointList { result, mediaEndPointList in
      switch result {
      case .success:
        guard let mediaEndPointList else { return }
        for (index, mediaEndPoint) in mediaEndPointList.enumerated() {
          Logger.media.info("Download Media (\(index + 1)/\(mediaEndPointList.count)): \(mediaEndPoint)")
          self.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
            if let error {
              Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
              completion(.failure(error), nil, nil)
            } else {
              Logger.media
                .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
              completion(.success(true), mediaEndPoint, progress)
            }
          }
        }

      case let .failure(error):
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        completion(.failure(error), nil, nil)
        return
      }
    }
  }

  func removeMedia(at offsets: IndexSet) {
    self
      .requestUsbMediaRemove(
        mediaEndPoint: self
          .mediaEndPointList[offsets[offsets.startIndex]]
      ) { error in
        if let error {
          Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
          return
        }

        // TODO: check
        self.mediaEndPointList.remove(atOffsets: offsets)
      }
  }

  func removeMedia(mediaEndPoint: String, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    Logger.media.info("Remove Media: \(mediaEndPoint)")
    self.requestUsbMediaRemove(mediaEndPoint: mediaEndPoint) { error in
      if let error {
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        completion(.failure(error))
      } else {
        Logger.media
          .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")

        // TODO: check
        if let mediaEndPointIndex = self.mediaEndPointList.firstIndex(of: mediaEndPoint) {
          self.mediaEndPointList.remove(at: mediaEndPointIndex)
        }
        completion(.success(true))
      }
    }
  }

  func removeAllMedia(_ completion: ((Result<Bool, Error>) -> Void)?) {
    self.updateMediaEndPointList { result, mediaEndPointList in
      switch result {
      case .success:
        guard let mediaEndPointList else { return }
        for (index, mediaEndPoint) in mediaEndPointList.enumerated() {
          Logger.media.info("Remove Media (\(index + 1)/\(mediaEndPointList.count)): \(mediaEndPoint)")
          self.requestUsbMediaRemove(mediaEndPoint: mediaEndPoint) { error in
            if let error {
              Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
              completion?(.failure(error))
            } else {
              Logger.media
                .info("Success: \(#function): \(Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue))")
              completion?(.success(true))
            }
          }
        }

      case let .failure(error):
        Logger.media.error("Fail: \(#function): \(error.localizedDescription)")
        completion?(.failure(error))
        return
      }
    }
  }

}
