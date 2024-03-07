//
//  FileItemInfo.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation

struct FileItemInfo: Hashable {
  let url: URL
  var childrenItem: [FileItemInfo]?

  var icon: String {
    if self.childrenItem == nil {
      return "photo"
    } else if self.childrenItem?.isEmpty == true {
      return "folder"
    } else {
      return "folder.fill"
    }
  }
}
