//
//  Peropheral+Media.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/18/23.
//

import Foundation
import Alamofire
import os.log



enum GoProWiFiCommand {
    case get_media_list

    var endPoint: String {
        switch self {
        case .get_media_list:
            return "/gopro/media/list"
        }
    }
}

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


extension Peripheral {
    static func requestWiFiCommand(serialNumber: Int, command: GoProWiFiCommand, _ completion: (([String], Error?) -> Void)?) {
        let serialX = Int(Double(serialNumber) / 100.0)
        let serialYZ = serialNumber - serialX * 100
        let url = "http://172.2" + String(serialX) + ".1" + String(serialYZ) + ".51:8080" + command.endPoint
        os_log("url: %@", type: .info, url)

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
                switch response.result{
                case .success (let obj):
                    var mediaList: [String] = []
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let mediaListJson = try JSONDecoder().decode(MediaListInfo.self, from: dataJSON)
                        print(mediaListJson)
                        os_log("json.id: %@", type: .info, mediaListJson.id)
                        os_log("json.media[0].d: %@", type: .info, mediaListJson.media[0].d)

                        for mediaInfo in mediaListJson.media {
                            for fileInfo in mediaInfo.fs {
                                mediaList.append("/videos/DCIM/" + mediaInfo.d + "/" + fileInfo.n)
                            }
                        }
                        os_log("mediaList: %@", type: .info, mediaList.description)
                        completion?(mediaList, nil)
                    } catch {
                        os_log("error: %@", type: .error, error.localizedDescription)
                        completion?([], error)
                    }
                case .failure (let error):
                    os_log("error: %@", type: .error, error as CVarArg)
                }
            }
    }
}
