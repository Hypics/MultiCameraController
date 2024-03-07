//
//  GoProUsbSetting.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/23/23.
//

enum GoProUsbSetting {
  case videoResolution_5_3k_16_9
  case videoResolution_5_3k_8_7
  case videoResolution_4k_4_3
  case videoResolution_4k_16_9
  case videoResolution_4k_8_7
  case videoResolution_4k_9_16
  case videoResolution_2_7k_4_3
  case videoResolution_2_7k_16_9
  case videoResolution_1080_16_9
  case videoResolution_1080_9_16
  case fps_240
  case fps_200
  case fps_120
  case fps_100
  case fps_60
  case fps_50
  case fps_30
  case fps_25
  case fps_24
  case autoPowerDown_never
  case autoPowerDown_8sec
  case autoPowerDown_30sec
  case autoPowerDown_1min
  case autoPowerDown_5min
  case autoPowerDown_15min
  case autoPowerDown_30min
  case videoAspectRatio_4_3
  case videoAspectRatio_16_9
  case videoAspectRatio_8_7
  case videoAspectRatio_9_16
  case videoDigitalLenses_hyperview
  case videoDigitalLenses_superview
  case videoDigitalLenses_wide
  case videoDigitalLenses_linear
  case videoDigitalLenses_linear_horizon_leveling
  case videoDigitalLenses_linear_horizon_lock
  case antiFlicker_60
  case antiFlicker_50
  case hypersmooth_off
  case hypersmooth_low
  case hypersmooth_auto_boost
  case hindsight_15sec
  case hindsight_30sec
  case hindsight_off
  case controls_easy
  case controls_pro
  case wirelessBand_2_4ghz
  case wirelessBand_5ghz
  case systemVideoBitRate_standard
  case systemVideoBitRate_high
  case systemVideoBitDepth_8bit
  case systemVideoBitDepth_10bit

  var endPoint: String {
    switch self {
    case .videoResolution_5_3k_16_9:
      "/gopro/camera/setting?setting=2&option=101"
    case .videoResolution_5_3k_8_7:
      "/gopro/camera/setting?setting=2&option=26"
    case .videoResolution_4k_4_3:
      "/gopro/camera/setting?setting=2&option=103"
    case .videoResolution_4k_16_9:
      "/gopro/camera/setting?setting=2&option=102"
    case .videoResolution_4k_8_7:
      "/gopro/camera/setting?setting=2&option=28"
    case .videoResolution_4k_9_16:
      "/gopro/camera/setting?setting=2&option=29"
    case .videoResolution_2_7k_4_3:
      "/gopro/camera/setting?setting=2&option=105"
    case .videoResolution_2_7k_16_9:
      "/gopro/camera/setting?setting=2&option=104"
    case .videoResolution_1080_16_9:
      "/gopro/camera/setting?setting=2&option=106"
    case .videoResolution_1080_9_16:
      "/gopro/camera/setting?setting=2&option=30"
    case .fps_240:
      "/gopro/camera/setting?setting=3&option=0"
    case .fps_200:
      "/gopro/camera/setting?setting=3&option=13"
    case .fps_120:
      "/gopro/camera/setting?setting=3&option=1"
    case .fps_100:
      "/gopro/camera/setting?setting=3&option=2"
    case .fps_60:
      "/gopro/camera/setting?setting=3&option=5"
    case .fps_50:
      "/gopro/camera/setting?setting=3&option=6"
    case .fps_30:
      "/gopro/camera/setting?setting=3&option=8"
    case .fps_25:
      "/gopro/camera/setting?setting=3&option=9"
    case .fps_24:
      "/gopro/camera/setting?setting=3&option=10"
    case .autoPowerDown_never:
      "/gopro/camera/setting?setting=59&option=0"
    case .autoPowerDown_8sec:
      "/gopro/camera/setting?setting=59&option=11"
    case .autoPowerDown_30sec:
      "/gopro/camera/setting?setting=59&option=12"
    case .autoPowerDown_1min:
      "/gopro/camera/setting?setting=59&option=1"
    case .autoPowerDown_5min:
      "/gopro/camera/setting?setting=59&option=4"
    case .autoPowerDown_15min:
      "/gopro/camera/setting?setting=59&option=6"
    case .autoPowerDown_30min:
      "/gopro/camera/setting?setting=59&option=7"
    case .videoAspectRatio_4_3:
      "/gopro/camera/setting?setting=108&option=0"
    case .videoAspectRatio_16_9:
      "/gopro/camera/setting?setting=108&option=1"
    case .videoAspectRatio_8_7:
      "/gopro/camera/setting?setting=108&option=3"
    case .videoAspectRatio_9_16:
      "/gopro/camera/setting?setting=108&option=4"
    case .videoDigitalLenses_hyperview:
      "/gopro/camera/setting?setting=121&option=9"
    case .videoDigitalLenses_superview:
      "/gopro/camera/setting?setting=121&option=3"
    case .videoDigitalLenses_wide:
      "/gopro/camera/setting?setting=121&option=0"
    case .videoDigitalLenses_linear:
      "/gopro/camera/setting?setting=121&option=4"
    case .videoDigitalLenses_linear_horizon_leveling:
      "/gopro/camera/setting?setting=121&option=8"
    case .videoDigitalLenses_linear_horizon_lock:
      "/gopro/camera/setting?setting=121&option=10"
    case .antiFlicker_60:
      "/gopro/camera/setting?setting=134&option=2"
    case .antiFlicker_50:
      "/gopro/camera/setting?setting=134&option=3"
    case .hypersmooth_off:
      "/gopro/camera/setting?setting=135&option=0"
    case .hypersmooth_low:
      "/gopro/camera/setting?setting=135&option=1"
    case .hypersmooth_auto_boost:
      "/gopro/camera/setting?setting=135&option=4"
    case .hindsight_15sec:
      "/gopro/camera/setting?setting=167&option=2"
    case .hindsight_30sec:
      "/gopro/camera/setting?setting=167&option=3"
    case .hindsight_off:
      "/gopro/camera/setting?setting=167&option=4"
    case .controls_easy:
      "/gopro/camera/setting?setting=175&option=0"
    case .controls_pro:
      "/gopro/camera/setting?setting=175&option=1"
    case .wirelessBand_2_4ghz:
      "/gopro/camera/setting?setting=178&option=0"
    case .wirelessBand_5ghz:
      "/gopro/camera/setting?setting=178&option=1"
    case .systemVideoBitRate_standard:
      "/gopro/camera/setting?setting=182&option=0"
    case .systemVideoBitRate_high:
      "/gopro/camera/setting?setting=182&option=1"
    case .systemVideoBitDepth_8bit:
      "/gopro/camera/setting?setting=183&option="
    case .systemVideoBitDepth_10bit:
      "/gopro/camera/setting?setting=183&option=2"
    }
  }
}
