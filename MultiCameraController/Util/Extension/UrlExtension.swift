//
//  UrlExtension.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 12/17/23.
//

import Foundation
import os.log

extension URL {
  func createDirectory(appendPath: String) -> URL {
    let path = appendingPathComponent(appendPath)
    if !FileManager.default.fileExists(atPath: path.path) {
      do {
        try FileManager.default.createDirectory(
          atPath: path.path,
          withIntermediateDirectories: false,
          attributes: nil
        )
      } catch {
        os_log("Failed to create directory: %@", type: .error, error.localizedDescription)
      }
    }
    return path
  }

  var isDirectory: Bool {
    (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
  }

  var subDirectories: [URL] {
    guard self.isDirectory else { return [] }
    return (try? FileManager.default.contentsOfDirectory(
      at: self,
      includingPropertiesForKeys: nil,
      options: [.skipsHiddenFiles]
    ).filter(\.isDirectory)) ?? []
  }
}