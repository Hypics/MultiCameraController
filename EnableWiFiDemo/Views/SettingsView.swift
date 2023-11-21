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
                    os_log("Video Resolution: 4K", type: .info)
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
                    os_log("Video Aspect: 16:9", type: .info)
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "aspectratio")
                            .foregroundColor(.red)
                        Text("Video Aspect: 16:9")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Video Digital Lens: Linear", type: .info)
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
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "warninglight")
                            .foregroundColor(.orange)
                        Text("Anti Flicker: 60Hz")
                            .foregroundColor(.orange)
                        Spacer()
                    }
                })
                .listRowSeparator(.hidden)
                Button(action: {
                    os_log("Hypersmooth: Off", type: .info)
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
                    os_log("System Video Bit Rate: High", type: .info)
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
