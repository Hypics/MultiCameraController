/* Peripheral+Camera.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:08 PM */

//
//  Peripheral+Camera.swift
//  EnableWiFiDemo
//

import CoreBluetooth
import os.log

/// A struct representing the camera's Wi-Fi settings
struct WiFiSettings {
    var SSID: String
    let password: String
}

enum GoProBleCommand {
    case shutter_off, shutter_on
    case sleep
    case apMode_off, apMode_on

    var data: Data {
        switch self {
        case .shutter_off:
            return Data([0x03, 0x01, 0x01, 0x00])
        case .shutter_on:
            return Data([0x03, 0x01, 0x01, 0x01])
        case .sleep:
            return Data([0x01, 0x05])
        case .apMode_off:
            return Data([0x03, 0x17, 0x01, 0x00])
        case .apMode_on:
            return Data([0x03, 0x17, 0x01, 0x01])
        }
    }
}

enum GoProSetting {
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
    case controls_easy, controls_pro
    case wirelessBand_2_4ghz, wirelessBand_5ghz
    case systemVideoBitRate_standard, systemVideoBitRate_high
    case systemVideoBitDepth_8bit, systemVideoBitDepth_10bit


    var data: Data {
        switch self {
        case .videoResolution_5_3k_16_9:
            return Data([0x03, 0x02, 0x01, 0x65])
        case .videoResolution_5_3k_8_7:
            return Data([0x03, 0x02, 0x01, 0x1A])
        case .videoResolution_4k_4_3:
            return Data([0x03, 0x02, 0x01, 0x67])
        case .videoResolution_4k_16_9:
            return Data([0x03, 0x02, 0x01, 0x66])
        case .videoResolution_4k_8_7:
            return Data([0x03, 0x02, 0x01, 0x1C])
        case .videoResolution_4k_9_16:
            return Data([0x03, 0x02, 0x01, 0x1D])
        case .videoResolution_2_7k_4_3:
            return Data([0x03, 0x02, 0x01, 0x69])
        case .videoResolution_2_7k_16_9:
            return Data([0x03, 0x02, 0x01, 0x68])
        case .videoResolution_1080_16_9:
            return Data([0x03, 0x02, 0x01, 0x6A])
        case .videoResolution_1080_9_16:
            return Data([0x03, 0x02, 0x01, 0x1E])
        case .fps_240:
            return Data([0x03, 0x03, 0x01, 0x00])
        case .fps_200:
            return Data([0x03, 0x03, 0x01, 0x0D])
        case .fps_120:
            return Data([0x03, 0x03, 0x01, 0x01])
        case .fps_100:
            return Data([0x03, 0x03, 0x01, 0x02])
        case .fps_60:
            return Data([0x03, 0x03, 0x01, 0x05])
        case .fps_50:
            return Data([0x03, 0x03, 0x01, 0x06])
        case .fps_30:
            return Data([0x03, 0x03, 0x01, 0x08])
        case .fps_25:
            return Data([0x03, 0x03, 0x01, 0x09])
        case .fps_24:
            return Data([0x03, 0x03, 0x01, 0x0A])
        case .autoPowerDown_never:
            return Data([0x03, 0x3B, 0x01, 0x00])
        case .autoPowerDown_8sec:
            return Data([0x03, 0x3B, 0x01, 0x0B])
        case .autoPowerDown_30sec:
            return Data([0x03, 0x3B, 0x01, 0x0C])
        case .autoPowerDown_1min:
            return Data([0x03, 0x3B, 0x01, 0x01])
        case .autoPowerDown_5min:
            return Data([0x03, 0x3B, 0x01, 0x04])
        case .autoPowerDown_15min:
            return Data([0x03, 0x3B, 0x01, 0x06])
        case .autoPowerDown_30min:
            return Data([0x03, 0x3B, 0x01, 0x07])
        case .videoAspectRatio_4_3:
            return Data([0x03, 0x6C, 0x01, 0x00])
        case .videoAspectRatio_16_9:
            return Data([0x03, 0x6C, 0x01, 0x01])
        case .videoAspectRatio_8_7:
            return Data([0x03, 0x6C, 0x01, 0x03])
        case .videoAspectRatio_9_16:
            return Data([0x03, 0x6C, 0x01, 0x04])
        case .videoDigitalLenses_hyperview:
            return Data([0x03, 0x79, 0x01, 0x09])
        case .videoDigitalLenses_superview:
            return Data([0x03, 0x79, 0x01, 0x09])
        case .videoDigitalLenses_wide:
            return Data([0x03, 0x79, 0x01, 0x03])
        case .videoDigitalLenses_linear:
            return Data([0x03, 0x79, 0x01, 0x04])
        case .videoDigitalLenses_linear_horizon_leveling:
            return Data([0x03, 0x79, 0x01, 0x08])
        case .videoDigitalLenses_linear_horizon_lock:
            return Data([0x03, 0x79, 0x01, 0x0A])
        case .antiFlicker_60:
            return Data([0x03, 0x86, 0x01, 0x02])
        case .antiFlicker_50:
            return Data([0x03, 0x86, 0x01, 0x03])
        case .hypersmooth_off:
            return Data([0x03, 0x87, 0x01, 0x00])
        case .hypersmooth_low:
            return Data([0x03, 0x87, 0x01, 0x00])
        case .hypersmooth_auto_boost:
            return Data([0x03, 0x87, 0x01, 0x00])
        case .controls_easy:
            return Data([0x03, 0xAF, 0x01, 0x00])
        case .controls_pro:
            return Data([0x03, 0xAF, 0x01, 0x01])
        case .wirelessBand_2_4ghz:
            return Data([0x03, 0xB2, 0x01, 0x00])
        case .wirelessBand_5ghz:
            return Data([0x03, 0xB2, 0x01, 0x01])
        case .systemVideoBitRate_standard:
            return Data([0x03, 0xB6, 0x01, 0x00])
        case .systemVideoBitRate_high:
            return Data([0x03, 0xB6, 0x01, 0x01])
        case .systemVideoBitDepth_8bit:
            return Data([0x03, 0xB7, 0x01, 0x00])
        case .systemVideoBitDepth_10bit:
            return Data([0x03, 0xB7, 0x01, 0x02])
        }
    }
}


extension Peripheral {
    func requestCommand(command: GoProBleCommand, _ completion: ((Error?) -> Void)?) {

        let serviceUUID = CBUUID(string: "FEA6")
        let commandUUID = CBUUID(string: "B5F90072-AA8D-11E3-9046-0002A5D5C51B")
        let commandResponseUUID = CBUUID(string: "B5F90073-AA8D-11E3-9046-0002A5D5C51B")

        let finishWithError: (Error?) -> Void = { error in
            // make sure to dispatch the result on the main thread
            DispatchQueue.main.async {
                completion?(error)
            }
        }

        registerObserver(serviceUUID: serviceUUID, characteristicUUID: commandResponseUUID) { data in

            // The response to the command to request command is expected to be 3 bytes
            if data.count != 3 {
                finishWithError(CameraError.invalidResponse)
                return
            }

            // The third byte represents the camera response. If the byte is 0x00 then the request was successful
            finishWithError(data[2] == 0x00 ? nil : CameraError.responseError)

        } completion: { [weak self] error in
            // Check that we successfully enable the notification for the response before writing to the characteristic
            if error != nil { finishWithError(error); return }
            self?.write(data: command.data, serviceUUID: serviceUUID, characteristicUUID: commandUUID) { error in
                finishWithError(error)
                os_log("sent requestCommand", type: .debug)
            }
        }
    }

    func requestSetting(setting: GoProSetting, _ completion: ((Error?) -> Void)?) {

        let serviceUUID = CBUUID(string: "FEA6")
        let commandUUID = CBUUID(string: "B5F90074-AA8D-11E3-9046-0002A5D5C51B")
        let commandResponseUUID = CBUUID(string: "B5F90075-AA8D-11E3-9046-0002A5D5C51B")

        let finishWithError: (Error?) -> Void = { error in
            // make sure to dispatch the result on the main thread
            DispatchQueue.main.async {
                completion?(error)
            }
        }

        registerObserver(serviceUUID: serviceUUID, characteristicUUID: commandResponseUUID) { data in

            // The response to the command to request setting is expected to be 3 bytes
            if data.count != 3 {
                finishWithError(CameraError.invalidResponse)
                return
            }

            // The third byte represents the camera response. If the byte is 0x00 then the request was successful
            finishWithError(data[2] == 0x00 ? nil : CameraError.responseError)

        } completion: { [weak self] error in
            // Check that we successfully enable the notification for the response before writing to the characteristic
            if error != nil { finishWithError(error); return }
            self?.write(data: setting.data, serviceUUID: serviceUUID, characteristicUUID: commandUUID) { error in
                finishWithError(error)
                os_log("sent requestSetting", type: .debug)
            }
        }
    }

    /// Reads camera's Wi-Fi settings
    /// - Parameter completion: The completion handler with a result representing either a success or a failure.
    ///                         In the success case, the associated value is an instance of WiFiSettings
    ///
    /// Discussion:
    /// Requesting Wi-Fi setting consists in reading characteristics GP-0002 (SSID) and GP-0003 (password)
    /// on the GoPro WiFi Access Point service

    func requestWiFiSettings(_ completion: ((Result<WiFiSettings, Error>) -> Void)?) {
        let serviceUUID = CBUUID(string: "B5F90001-AA8D-11E3-9046-0002A5D5C51B")
        var SSID: String?
        var password: String?

        let finishWithResult: (Result<WiFiSettings, Error>) -> Void = { result in
            // make sure to dispatch the result on the main thread
            DispatchQueue.main.async {
                completion?(result)
            }
        }

        let reads = DispatchGroup()
        reads.enter()
        readData(from: CBUUID(string: "B5F90002-AA8D-11E3-9046-0002A5D5C51B"), serviceUUID: serviceUUID) { result in
            switch result {
            case .success(let data):
                // we got the data, let's convert to a string
                SSID = String(bytes: data.subdata(in: 0..<data.count), encoding: .utf8)
            case .failure(let error):
                finishWithResult(.failure(error))
            }
            reads.leave()
        }

        reads.enter()
        readData(from: CBUUID(string: "B5F90003-AA8D-11E3-9046-0002A5D5C51B"), serviceUUID: serviceUUID) { result in
            switch result {
            case .success(let data):
                // we got the data, let's convert to a string
                password = String(bytes: data.subdata(in: 0..<data.count), encoding: .utf8)
            case .failure(let error):
                finishWithResult(.failure(error))
            }
            reads.leave()
        }

        reads.notify(queue: .main) {
            guard let SSID = SSID, let password = password else {
                finishWithResult(.failure(CameraError.invalidResponse))
                return
            }

            finishWithResult(.success(WiFiSettings(SSID: SSID, password: password)))
            os_log("received requestWiFiSettings", type: .debug)
        }
    }
}
