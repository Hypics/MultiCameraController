//
//  Peropheral+Media.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/18/23.
//

import Alamofire
import os.log



enum GoProUsbCommand {
    case getMediaList
    case getHardwareInfo

    var endPoint: String {
        switch self {
        case .getMediaList:
            return "/gopro/media/list"
        case .getHardwareInfo:
            return "/gopro/camera/info"
        }
    }
}

struct CameraInfo: Codable {
    var ap_mac_addr: String
    var ap_ssid: String
    var firmware_version: String
    var model_name: String
    var model_number: String
    var serial_number: String
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

final class GoPro: NSObject {
    let serialNumber: String
    let url: String

    init(serialNumber: String) {
        self.serialNumber = serialNumber
        let serialNumberX = serialNumber.substring(with: 0 ..< 1)
        let serialNumberYZ = serialNumber.substring(with: 1 ..< 3)
        self.url = "http://172.2" + serialNumberX + ".1" + serialNumberYZ + ".51:8080"
    }

    func requestUsbCommand(command: GoProUsbCommand, _ completion: (([String], Error?) -> Void)?) {
        let commandUrl = self.url + command.endPoint
        os_log("url: %@", type: .info, commandUrl)

        AF.request(commandUrl,
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

    func requestUsbCameraInfo(_ completion: ((CameraInfo?, Error?) -> Void)?) {
        let commandUrl = self.url + GoProUsbCommand.getHardwareInfo.endPoint
        os_log("url: %@", type: .info, commandUrl)

        AF.request(commandUrl,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200 ..< 300)
            .responseJSON { response in
            switch response.result{
            case .success (let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let cameraInfoJson = try JSONDecoder().decode(CameraInfo.self, from: dataJSON)
                    print(cameraInfoJson)
                    completion?(cameraInfoJson, nil)
                } catch {
                    os_log("error: %@", type: .error, error.localizedDescription)
                    completion?(nil, error)
                }
            case .failure (let error):
                os_log("error: %@", type: .error, error as CVarArg)
            }
        }
    }

    func requestUsbMediaList(_ completion: (([String], Error?) -> Void)?) {
        let commandUrl = self.url + GoProUsbCommand.getMediaList.endPoint
        os_log("url: %@", type: .info, commandUrl)

        AF.request(commandUrl,
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
//                    print(mediaListJson)
                    os_log("json.id: %@", type: .debug, mediaListJson.id)
                    os_log("json.media[0].d: %@", type: .debug, mediaListJson.media[0].d)

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

    func requestUsbMedia(mediaEndPoint: String, method: HTTPMethod, _ completion: ((Double, Error?) -> Void)?) {
        let fileManager = FileManager.default
        let appURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName : String = URL(string: mediaEndPoint)!.lastPathComponent
        let fileURL = appURL.appendingPathComponent(fileName)
        let destination: DownloadRequest.Destination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        let mediaUrl = self.url + mediaEndPoint
        AF.download(mediaUrl, method: method, parameters: nil, encoding: JSONEncoding.default, to: destination).downloadProgress { (progress) in
            completion?(Double(progress.fractionCompleted * 100), nil)
        }.response{ response in
                if response.error != nil {
                    os_log("Download failed: %@", type: .error, response.error?.errorDescription ?? "")
                } else {
                    os_log("Download Success", type: .info)
                }
        }
    }

    func requestUsbMediaDownload(mediaEndPoint: String, _ completion: ((Double, Error?) -> Void)?) {
        requestUsbMedia(mediaEndPoint: mediaEndPoint, method: .get, completion)
    }

    func requestUsbMediaRemove(mediaEndPoint: String, _ completion: ((Double, Error?) -> Void)?) {
        requestUsbMedia(mediaEndPoint: mediaEndPoint, method: .delete, completion)
    }
}
