//
//  UrlExtensions.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 12/17/23.
//

import Foundation

extension URL {
  var isDirectory: Bool {
    (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
  }
}
