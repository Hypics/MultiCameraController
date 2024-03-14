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
  case startPreview
  case stopPreview

  var endPoint: String {
    switch self {
    case .getMediaList:
      "/gopro/media/list"
    case .getHardwareInfo:
      "/gopro/camera/info"
    case .shutterOn:
      "/gopro/camera/shutter/start"
    case .shutterOff:
      "/gopro/camera/shutter/stop"
    case .disableWiredUsbControl:
      "/gopro/camera/control/wired_usb?p=0"
    case .enableWiredUsbControl:
      "/gopro/camera/control/wired_usb?p=1"
    case .startPreview:
      "/gopro/camera/stream/start"
    case .stopPreview:
      "/gopro/camera/stream/stop"
    }
  }
}
