//
//  FileItemModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation

struct FileItemModel: Identifiable {
  let id = UUID()
  let url: URL
  var childrenItem: [FileItemModel]?

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
