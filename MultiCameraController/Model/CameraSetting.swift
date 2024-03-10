//
//  CameraSetting.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import Foundation

enum CameraPreset {
  case mounted_4k_60fps

  func toGoProSetting() -> [GoProUsbSetting] {
    switch self {
    case .mounted_4k_60fps:
      [
        .controls_pro,
        .videoAspectRatio_16_9,
        .videoResolution_4k_16_9,
        .fps_120,
        .videoDigitalLenses_linear,
        .antiFlicker_60,
        .hypersmooth_off,
        .hindsight_off,
        .systemVideoBitRate_high,
        .systemVideoBitDepth_10bit,
        .autoPowerDown_never,
        .wirelessBand_5ghz
      ]
    }
  }
}

enum CameraVideoResolution: CaseIterable {
  case videoResolution_1080
  case videoResolution_2_7k
  case videoResolution_4k
  case videoResolution_5_3k

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .videoResolution_1080:
      .videoResolution_1080_16_9

    case .videoResolution_2_7k:
      .videoResolution_2_7k_16_9

    case .videoResolution_4k:
      .videoResolution_4k_16_9

    case .videoResolution_5_3k:
      .videoResolution_5_3k_16_9
    }
  }
}

enum CameraFps: CaseIterable {
  case fps_24
  case fps_25
  case fps_30
  case fps_50
  case fps_60
  case fps_100
  case fps_120
  case fps_200
  case fps_240

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .fps_24:
      .fps_24

    case .fps_25:
      .fps_25

    case .fps_30:
      .fps_30

    case .fps_50:
      .fps_50

    case .fps_60:
      .fps_60

    case .fps_100:
      .fps_100

    case .fps_120:
      .fps_120

    case .fps_200:
      .fps_200

    case .fps_240:
      .fps_240
    }
  }
}

enum CameraAutoPowerDown: CaseIterable {
  case autoPowerDown_8sec
  case autoPowerDown_30sec
  case autoPowerDown_1min
  case autoPowerDown_5min
  case autoPowerDown_15min
  case autoPowerDown_30min
  case autoPowerDown_never

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .autoPowerDown_8sec:
      .autoPowerDown_8sec

    case .autoPowerDown_30sec:
      .autoPowerDown_30sec

    case .autoPowerDown_1min:
      .autoPowerDown_1min

    case .autoPowerDown_5min:
      .autoPowerDown_5min

    case .autoPowerDown_15min:
      .autoPowerDown_15min

    case .autoPowerDown_30min:
      .autoPowerDown_30min

    case .autoPowerDown_never:
      .autoPowerDown_never
    }
  }
}

enum CameraVideoAspectRatio: CaseIterable {
  case videoAspectRatio_4_3
  case videoAspectRatio_16_9
  case videoAspectRatio_8_7
  case videoAspectRatio_9_16

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .videoAspectRatio_4_3:
      .videoAspectRatio_4_3

    case .videoAspectRatio_16_9:
      .videoAspectRatio_16_9

    case .videoAspectRatio_8_7:
      .videoAspectRatio_8_7

    case .videoAspectRatio_9_16:
      .videoAspectRatio_9_16
    }
  }
}

enum CameraDigitalLenses: CaseIterable {
  case hyperview
  case superview
  case wide
  case linear
  case linear_horizon_leveling
  case linear_horizon_lock

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .hyperview:
      .videoDigitalLenses_hyperview

    case .superview:
      .videoDigitalLenses_superview

    case .wide:
      .videoDigitalLenses_wide

    case .linear:
      .videoDigitalLenses_linear

    case .linear_horizon_leveling:
      .videoDigitalLenses_linear_horizon_leveling

    case .linear_horizon_lock:
      .videoDigitalLenses_linear_horizon_lock
    }
  }
}

enum CameraAntiFlicker: CaseIterable {
  case antiFlicker_50
  case antiFlicker_60

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .antiFlicker_50:
      .antiFlicker_50

    case .antiFlicker_60:
      .antiFlicker_60
    }
  }
}

enum CameraHypersmooth: CaseIterable {
  case off
  case low
  case auto_boost

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .off:
      .hypersmooth_off

    case .low:
      .hypersmooth_low

    case .auto_boost:
      .hypersmooth_auto_boost
    }
  }
}

enum CameraHindsight: CaseIterable {
  case hindsight_15sec
  case hindsight_30sec
  case hindsight_off

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .hindsight_15sec:
      .hindsight_15sec

    case .hindsight_30sec:
      .hindsight_30sec

    case .hindsight_off:
      .hindsight_off
    }
  }
}

enum CameraControlMode: CaseIterable {
  case easy
  case pro

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .easy:
      .controls_easy

    case .pro:
      .controls_pro
    }
  }
}

enum CameraWirelessBand: CaseIterable {
  case wirelessBand_2_4ghz
  case wirelessBand_5ghz

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .wirelessBand_2_4ghz:
      .wirelessBand_2_4ghz

    case .wirelessBand_5ghz:
      .wirelessBand_5ghz
    }
  }
}

enum CameraVideoBitRate: CaseIterable {
  case standard
  case high

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .standard:
      .systemVideoBitRate_standard

    case .high:
      .systemVideoBitRate_high
    }
  }
}

enum CameraVideoBitDepth: CaseIterable {
  case videoBitDepth_8bit
  case videoBitDepth_10bit

  func toString() -> String {
    return "\(self)"
  }

  func toGoProSetting() -> GoProUsbSetting {
    switch self {
    case .videoBitDepth_8bit:
      .systemVideoBitDepth_8bit

    case .videoBitDepth_10bit:
      .systemVideoBitDepth_10bit
    }
  }
}
