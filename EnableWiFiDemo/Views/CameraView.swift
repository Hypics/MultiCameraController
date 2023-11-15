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
    var peripheral: Peripheral?
    var body: some View {
        VStack(content: {
            Text("Deep Frost Testing..").padding()
            Button(action: {
                os_log("Enabling WiFi...", type: .info)
                peripheral?.enableWiFi { error in
                    if error != nil {
                        print("\(error!)")
                        return
                    }

                    os_log("Requesting WiFi settings...", type: .info)
                    peripheral?.requestWiFiSettings { result in
                        switch result {
                        case .success(let wifiSettings):
                            joinWiFi(with: wifiSettings.SSID, password: wifiSettings.password)
                        case .failure(let error):
                            print("\(error)")
                        }
                    }
                }
            }, label: {
                Text("Enable Wi-Fi")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(peripheral?.name ?? "").fontWeight(.bold)
                }
            }.padding()
            Button(action: {
                os_log("Request Shutter on...", type: .info)
                peripheral?.requestShutter({ error in
                    if error != nil {
                        print("\(error!)")
                        return
                    }
                }, on: true)
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
                peripheral?.requestShutter({ error in
                    if error != nil {
                        print("\(error!)")
                        return
                    }
                }, on: false)
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
                peripheral?.requestSleep({ error in
                    if error != nil {
                        print("\(error!)")
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
    })
    }

    private func joinWiFi(with SSID: String, password: String) {
        os_log("Joining WiFi %@...", type: .info, SSID)
        let configuration = NEHotspotConfiguration(ssid: SSID, passphrase: password, isWEP: false)
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: SSID)
        configuration.joinOnce = false
        NEHotspotConfigurationManager.shared.apply(configuration) { error in
            guard let error = error else { os_log("Joining WiFi succeeded", type: .info); return }
            os_log("Joining WiFi failed: %@", type: .error, error as CVarArg)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
