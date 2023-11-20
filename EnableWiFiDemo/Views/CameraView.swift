/* CameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraView.swift
//  EnableWiFiDemo
//

import SwiftUI
import NetworkExtension
import os.log

struct CameraView: View {
    @Environment(\.dismiss)
    private var dismiss
    var peripheral: Peripheral?
    @State private var showCameraWiFiView = false
    var body: some View {
        VStack(content: {
            Text("Deep Frost Testing..").padding()
            Button(action: {
                os_log("Enabling WiFi...", type: .info)
                peripheral?.requestCommand(command: .apMode_on, { error in
                    if error != nil {
                        os_log("Error: %@", type: .error, error! as CVarArg)
                        return
                    }
                    os_log("Requesting WiFi settings...", type: .info)
                    peripheral?.requestWiFiSettings { result in
                        switch result {
                        case .success(let wifiSettings):
                            os_log("Join WiFi...", type: .info)
                            joinWiFi(with: wifiSettings.SSID, password: wifiSettings.password)
                            showCameraWiFiView=true
                        case .failure(let error):
                            os_log("Error: %@", type: .error, error as CVarArg)
                        }
                    }
                })
            }, label: {
                Text("Join Wi-Fi")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Set Settings...", type: .info)
                let goProSettings: [GoProSetting] = [.controls_pro, .videoAspectRatio_16_9, .videoResolution_4k_16_9, .fps_120, .videoDigitalLenses_linear, .antiFlicker_60, .hypersmooth_off, .systemVideoBitRate_high, .systemVideoBitDepth_10bit, .autoPowerDown_5min, .wirelessBand_5ghz]
                for (idx, goProSetting) in goProSettings.enumerated() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(idx) * 0.5) {
                        peripheral?.requestSetting(setting: goProSetting, { error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        })
                    }
                }
            }, label: {
                Text("Set Settings")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Request Shutter on...", type: .info)
                peripheral?.requestCommand(command: .shutter_on, { error in
                    if error != nil {
                        os_log("Error: %@", type: .error, error! as CVarArg)
                        return
                    }
                })
            }, label: {
                Text("Request Shutter on")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Request Shutter off...", type: .info)
                peripheral?.requestCommand(command: .shutter_off, { error in
                    if error != nil {
                        os_log("Error: %@", type: .error, error! as CVarArg)
                        return
                    }
                })
            }, label: {
                Text("Request Shutter off")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Request Sleep...", type: .info)
                peripheral?.requestCommand(command: .sleep, { error in
                    if error != nil {
                        os_log("Error: %@", type: .error, error! as CVarArg)
                        return
                    }
                })
            }, label: {
                Text("Request Sleep")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Go back...", type: .info)
                dismiss()
            }, label: {
                Text("Go back")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
        })
    }

    private func joinWiFi(with SSID: String, password: String) {
        os_log("Joining WiFi %@...", type: .info, SSID)
        let configuration = NEHotspotConfiguration(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: SSID)
        configuration.joinOnce = false
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            guard let error = error else {
                os_log("Joining WiFi succeeded", type: .info)
                return
            }
            os_log("Joining WiFi failed: %@", type: .error, error as CVarArg)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
