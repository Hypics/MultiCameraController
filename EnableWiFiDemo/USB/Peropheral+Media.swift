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
                var mediaUrlList: [String] = []
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let mediaListJson = try JSONDecoder().decode(MediaListInfo.self, from: dataJSON)
                    print(mediaListJson)
                    os_log("json.id: %@", type: .info, mediaListJson.id)
                    os_log("json.media[0].d: %@", type: .info, mediaListJson.media[0].d)

                    for mediaInfo in mediaListJson.media {
                        for fileInfo in mediaInfo.fs {
                            mediaUrlList.append("/videos/DCIM/" + mediaInfo.d + "/" + fileInfo.n)
                        }
                    }
                    os_log("mediaList: %@", type: .info, mediaUrlList.description)
                    completion?(mediaUrlList, nil)
                } catch {
                    os_log("error: %@", type: .error, error.localizedDescription)
                    completion?([], error)
                }
            case .failure (let error):
                os_log("error: %@", type: .error, error as CVarArg)
            }
        }
    }

    static func requestDownloadMedia(serialNumber: Int, endPoint: String) {
        let fileManager = FileManager.default
        let appURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName : String = URL(string: endPoint)!.lastPathComponent
        let fileURL = appURL.appendingPathComponent(fileName)
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        let serialX = Int(Double(serialNumber) / 100.0)
        let serialYZ = serialNumber - serialX * 100
        let url = "http://172.2" + String(serialX) + ".1" + String(serialYZ) + ".51:8080" + endPoint
        AF.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).downloadProgress { (progress) in
//            self.progressView.progress = Float(progress.fractionCompleted)
//            self.progressLabel.text = "\(Int(progress.fractionCompleted * 100))%"
            os_log("%@%", type: .debug, String(Int(progress.fractionCompleted * 100)))
        }.response{ response in
                if response.error != nil {
                    os_log("Download failed: %@", type: .error, response.error?.errorDescription ?? "")
                } else {
                    os_log("Download Success", type: .info)
                }
        }
    }
}
