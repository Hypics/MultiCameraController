//
//  GoProUsbCommand.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/23/23.
//

enum GoProUsbCommand {
    case getMediaList
    case getHardwareInfo
    case shutterOn
    case shutterOff
    case disableWiredUsbControl
    case enableWiredUsbControl

    var endPoint: String {
        switch self {
        case .getMediaList:
            return "/gopro/media/list"
        case .getHardwareInfo:
            return "/gopro/camera/info"
        case .shutterOn:
            return "/gopro/camera/shutter/start"
        case .shutterOff:
            return "/gopro/camera/shutter/stop"
        case .disableWiredUsbControl:
            return "/gopro/camera/control/wired_usb?p=0"
        case .enableWiredUsbControl:
            return "/gopro/camera/control/wired_usb?p=1"
        }
    }
}
