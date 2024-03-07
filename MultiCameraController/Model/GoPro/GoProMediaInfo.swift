//
//  GoProMediaInfo.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/23/23.
//

struct GoProMediaListInfo: Codable {
  var id: String
  var media: [GoProMediaInfo]
}

struct GoProMediaInfo: Codable {
  var d: String
  var fs: [GoProFileInfo]
}

struct GoProFileInfo: Codable {
  var ls: String
  var cre: String
  var mod: String
  var glrv: String
  var s: String
  var n: String
}
