//
//  GoProMediaInfo.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/23/23.
//

struct MediaListInfo: Codable {
    var id: String
    var media: [MediaInfo]
}

struct MediaInfo: Codable {
    var d: String
    var fs: [FileInfo]
}

struct FileInfo: Codable {
    var ls: String
    var cre: String
    var mod: String
    var glrv: String
    var s: String
    var n: String
}
