//
//  Peropheral+Media.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/18/23.
//

import Foundation
import os.log
import Alamofire



enum GoProWiFiCommand {
    case get_media_list

    var endPoint: String {
        switch self {
        case .get_media_list:
            return "/gopro/media/list"
        }
    }
}


extension Peripheral {
    func requestWiFiCommand(command: GoProWiFiCommand, _ completion: ((Error?) -> Void)?) {
        let url = "http://10.5.5.9:8080" + command.endPoint
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (json) in
                print(json)
            }
    }
}
