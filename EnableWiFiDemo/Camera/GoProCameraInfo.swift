//
//  GoProCameraInfo.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/23/23.
//

struct CameraConnectionInfo: Hashable {
    var camera: GoPro
    var isConnected: Bool = false
}

struct CameraInfo: Codable {
    var ap_mac_addr: String
    var ap_ssid: String
    var firmware_version: String
    var model_name: String
    var model_number: String
    var serial_number: String
}
