//
//  GoProUsbSetting.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/23/23.
//

enum goProUsbSettingPreset {
    case mounted_4k_120fps

    var settings: [GoProUsbSetting] {
        switch self {
        case .mounted_4k_120fps:
            return [.controls_pro, .videoAspectRatio_16_9, .videoResolution_4k_16_9, .fps_120, .videoDigitalLenses_linear, .antiFlicker_60, .hypersmooth_off, .hindsight_off, .systemVideoBitRate_high, .systemVideoBitDepth_10bit, .autoPowerDown_never, .wirelessBand_5ghz]
        }
    }
}

enum GoProUsbSetting {
    case videoResolution_5_3k_16_9, videoResolution_5_3k_8_7
    case videoResolution_4k_4_3, videoResolution_4k_16_9, videoResolution_4k_8_7, videoResolution_4k_9_16
    case videoResolution_2_7k_4_3, videoResolution_2_7k_16_9
    case videoResolution_1080_16_9, videoResolution_1080_9_16
    case fps_240, fps_200, fps_120, fps_100, fps_60, fps_50, fps_30, fps_25, fps_24
    case autoPowerDown_never, autoPowerDown_8sec, autoPowerDown_30sec, autoPowerDown_1min, autoPowerDown_5min, autoPowerDown_15min, autoPowerDown_30min
    case videoAspectRatio_4_3, videoAspectRatio_16_9, videoAspectRatio_8_7, videoAspectRatio_9_16
    case videoDigitalLenses_hyperview, videoDigitalLenses_superview, videoDigitalLenses_wide, videoDigitalLenses_linear, videoDigitalLenses_linear_horizon_leveling, videoDigitalLenses_linear_horizon_lock
    case antiFlicker_60, antiFlicker_50
    case hypersmooth_off, hypersmooth_low, hypersmooth_auto_boost
    case hindsight_15sec, hindsight_30sec, hindsight_off
    case controls_easy, controls_pro
    case wirelessBand_2_4ghz, wirelessBand_5ghz
    case systemVideoBitRate_standard, systemVideoBitRate_high
    case systemVideoBitDepth_8bit, systemVideoBitDepth_10bit


    var endPoint: String {
        switch self {
        case .videoResolution_5_3k_16_9:
            return "/gopro/camera/setting?setting=2&option=101"
        case .videoResolution_5_3k_8_7:
            return "/gopro/camera/setting?setting=2&option=26"
        case .videoResolution_4k_4_3:
            return "/gopro/camera/setting?setting=2&option=103"
        case .videoResolution_4k_16_9:
            return "/gopro/camera/setting?setting=2&option=102"
        case .videoResolution_4k_8_7:
            return "/gopro/camera/setting?setting=2&option=28"
        case .videoResolution_4k_9_16:
            return "/gopro/camera/setting?setting=2&option=29"
        case .videoResolution_2_7k_4_3:
            return "/gopro/camera/setting?setting=2&option=105"
        case .videoResolution_2_7k_16_9:
            return "/gopro/camera/setting?setting=2&option=104"
        case .videoResolution_1080_16_9:
            return "/gopro/camera/setting?setting=2&option=106"
        case .videoResolution_1080_9_16:
            return "/gopro/camera/setting?setting=2&option=30"
        case .fps_240:
            return "/gopro/camera/setting?setting=3&option=0"
        case .fps_200:
            return "/gopro/camera/setting?setting=3&option=13"
        case .fps_120:
            return "/gopro/camera/setting?setting=3&option=1"
        case .fps_100:
            return "/gopro/camera/setting?setting=3&option=2"
        case .fps_60:
            return "/gopro/camera/setting?setting=3&option=5"
        case .fps_50:
            return "/gopro/camera/setting?setting=3&option=6"
        case .fps_30:
            return "/gopro/camera/setting?setting=3&option=8"
        case .fps_25:
            return "/gopro/camera/setting?setting=3&option=9"
        case .fps_24:
            return "/gopro/camera/setting?setting=3&option=10"
        case .autoPowerDown_never:
            return "/gopro/camera/setting?setting=59&option=0"
        case .autoPowerDown_8sec:
            return "/gopro/camera/setting?setting=59&option=11"
        case .autoPowerDown_30sec:
            return "/gopro/camera/setting?setting=59&option=12"
        case .autoPowerDown_1min:
            return "/gopro/camera/setting?setting=59&option=1"
        case .autoPowerDown_5min:
            return "/gopro/camera/setting?setting=59&option=4"
        case .autoPowerDown_15min:
            return "/gopro/camera/setting?setting=59&option=6"
        case .autoPowerDown_30min:
            return "/gopro/camera/setting?setting=59&option=7"
        case .videoAspectRatio_4_3:
            return "/gopro/camera/setting?setting=108&option=0"
        case .videoAspectRatio_16_9:
            return "/gopro/camera/setting?setting=108&option=1"
        case .videoAspectRatio_8_7:
            return "/gopro/camera/setting?setting=108&option=3"
        case .videoAspectRatio_9_16:
            return "/gopro/camera/setting?setting=108&option=4"
        case .videoDigitalLenses_hyperview:
            return "/gopro/camera/setting?setting=121&option=9"
        case .videoDigitalLenses_superview:
            return "/gopro/camera/setting?setting=121&option=3"
        case .videoDigitalLenses_wide:
            return "/gopro/camera/setting?setting=121&option=0"
        case .videoDigitalLenses_linear:
            return "/gopro/camera/setting?setting=121&option=4"
        case .videoDigitalLenses_linear_horizon_leveling:
            return "/gopro/camera/setting?setting=121&option=8"
        case .videoDigitalLenses_linear_horizon_lock:
            return "/gopro/camera/setting?setting=121&option=10"
        case .antiFlicker_60:
            return "/gopro/camera/setting?setting=134&option=2"
        case .antiFlicker_50:
            return "/gopro/camera/setting?setting=134&option=3"
        case .hypersmooth_off:
            return "/gopro/camera/setting?setting=135&option=0"
        case .hypersmooth_low:
            return "/gopro/camera/setting?setting=135&option=1"
        case .hypersmooth_auto_boost:
            return "/gopro/camera/setting?setting=135&option=4"
        case .hindsight_15sec:
            return "/gopro/camera/setting?setting=167&option=2"
        case .hindsight_30sec:
            return "/gopro/camera/setting?setting=167&option=3"
        case .hindsight_off:
            return "/gopro/camera/setting?setting=167&option=4"
        case .controls_easy:
            return "/gopro/camera/setting?setting=175&option=0"
        case .controls_pro:
            return "/gopro/camera/setting?setting=175&option=1"
        case .wirelessBand_2_4ghz:
            return "/gopro/camera/setting?setting=178&option=0"
        case .wirelessBand_5ghz:
            return "/gopro/camera/setting?setting=178&option=1"
        case .systemVideoBitRate_standard:
            return "/gopro/camera/setting?setting=182&option=0"
        case .systemVideoBitRate_high:
            return "/gopro/camera/setting?setting=182&option=1"
        case .systemVideoBitDepth_8bit:
            return "/gopro/camera/setting?setting=183&option="
        case .systemVideoBitDepth_10bit:
            return "/gopro/camera/setting?setting=183&option=2"
        }
    }
}
