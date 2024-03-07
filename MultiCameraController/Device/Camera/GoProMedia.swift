//
//  GoProMedia.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation
import os.log

extension GoPro {
  func updateMediaEndPointList(_ completion: ((Result<Bool, Error>, [String]?) -> Void)?) {
    os_log("Update Media EndPoint List: %@", type: .info, self.cameraName)
    self.requestUsbMediaList { mediaEndPointList, _, error in
      if let error {
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error), nil)
      } else { os_log(
        "Success: %@: %@",
        type: .info,
        #function,
        Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
      )
      self.mediaEndPointList = mediaEndPointList ?? []
      completion?(.success(true), mediaEndPointList)
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

  func downloadAllMedia(_ completion: @escaping (Result<Bool, Error>, String?, Double?) -> Void) {
    self.updateMediaEndPointList { result, mediaEndPointList in
      switch result {
      case .success:
        guard let mediaEndPointList else { return }
        for (index, mediaEndPoint) in mediaEndPointList.enumerated() {
          os_log("Download Media (%@/%@): %@", type: .info, index + 1, mediaEndPointList.count, mediaEndPoint)
          self.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint, timestamp_path: nil) { progress, error in
            if let error {
              os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
              completion(.failure(error), nil, nil)
            } else {
              os_log(
                "Success: %@: %@",
                type: .info,
                #function,
                Date().toString(CustomDateFormat.yearToFractionalSecond.rawValue)
              )
              completion(.success(true), mediaEndPoint, progress)
            }
          }
        }

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion(.failure(error), nil, nil)
        return
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
        // TODO: remove item?
        completion(.success(true))
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
          os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
          return
        }
        self.mediaEndPointList.remove(atOffsets: offsets)
      }
  }

  func removeAllMedia(_ completion: ((Result<Bool, Error>) -> Void)?) {
    self.updateMediaEndPointList { result, mediaEndPointList in
      switch result {
      case .success:
        guard let mediaEndPointList else { return }
        for (index, mediaEndPoint) in mediaEndPointList.enumerated() {
          os_log("Download Media (%@/%@): %@", type: .info, index + 1, mediaEndPointList.count, mediaEndPoint)
          self.requestUsbMediaRemove(mediaEndPoint: mediaEndPoint) { error in
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

      case let .failure(error):
        os_log("Fail: %@: %@", type: .error, #function, error.localizedDescription)
        completion?(.failure(error))
        return
      }
    }
  }

}
