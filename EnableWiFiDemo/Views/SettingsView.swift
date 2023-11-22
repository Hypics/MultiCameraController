//
//  SettingsView.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/20/23.
//

import SwiftUI
import os.log

struct SettingsView: View {
    var cameraSerialNumberList: [String]
    var body: some View {
        VStack {
            Divider().padding()
            Button(action: {
                os_log("4K@120FPS, 16:9, Linear, 60Hz, Off, High, 10bit, Never, Pro", type: .info)
                for cameraSerialNumber in cameraSerialNumberList {
                    for presetSetting in goProUsbPreset.mounted_4k_120fps.settings {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: presetSetting) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }
            }, label: {
                VStack {
                    Image(systemName: "1.square")
                        .foregroundColor(.pink)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Text("4K@120FPS, 16:9, Linear")
                        .foregroundColor(.primary)
                    Text("60Hz, Off, High, 10bit, Never, Pro")
                        .foregroundColor(.primary)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
            })
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 1.0)
            )
            Divider().padding()
            List {
                Button(action: {
                    os_log("Video Resolution: 4K, 16:9", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .videoResolution_4k_16_9) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "camera")
                            .foregroundColor(.pink)
                        Text("Video Resolution: 4K")
                            .foregroundColor(.pink)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Video FPS: 120Hz", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .fps_120) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.on.rectangle")
                            .foregroundColor(.pink)
                        Text("Video FPS: 120Hz")
                            .foregroundColor(.pink)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Video Digital Lens: Linear", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .videoDigitalLenses_linear) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "field.of.view.wide")
                            .foregroundColor(.red)
                        Text("Video Digital Lens: Linear")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Anti Flicker: 60Hz", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .antiFlicker_60) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "warninglight")
                            .foregroundColor(.red)
                        Text("Anti Flicker: 60Hz")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Hypersmooth: Off", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .hypersmooth_off) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "circle.and.line.horizontal")
                            .foregroundColor(.orange)
                        Text("Hypersmooth: Off")
                            .foregroundColor(.orange)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Hindsight: Off", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .hindsight_off) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "aspectratio")
                            .foregroundColor(.orange)
                        Text("Hindsight: Off")
                            .foregroundColor(.orange)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("System Video Bit Rate: High", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .systemVideoBitRate_high) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.teal)
                        Text("System Video Bit Rate: High")
                            .foregroundColor(.teal)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("System Video Bit Depth: 10bit", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .systemVideoBitDepth_10bit) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.teal)
                        Text("System Video Bit Depth: 10bit")
                            .foregroundColor(.teal)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Auto Power Down: Never", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .autoPowerDown_never) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "powersleep")
                            .foregroundColor(.indigo)
                        Text("Auto Power Down: Never")
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Controls Mode: Pro", type: .info)
                    for cameraSerialNumber in cameraSerialNumberList {
                        let caemra = GoPro(serialNumber: cameraSerialNumber)
                        caemra.requestUsbSetting(setting: .controls_pro) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "wrench.and.screwdriver")
                            .foregroundColor(.indigo)
                        Text("Controls Mode: Pro")
                            .foregroundColor(.indigo)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings Control").fontWeight(.bold)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(cameraSerialNumberList: [])
    }
}
