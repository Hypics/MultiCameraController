//
//  SettingsView.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/20/23.
//

import SwiftUI
import os.log

struct SettingsView: View {
    @Environment(\.dismiss)
    private var dismiss
    var peripheral: Peripheral?
    @State private var showCameraWiFiView = false
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
                        .foregroundColor(.black)
                    Text("60Hz, Off, High, 10bit, Never, Pro")
                        .foregroundColor(.black)
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
                            .foregroundColor(.orange)
                        Text("Video Resolution: 4K")
                            .foregroundColor(.orange)
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
                            .foregroundColor(.orange)
                        Text("Video FPS: 120Hz")
                            .foregroundColor(.orange)
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
                            .foregroundColor(.mint)
                        Text("Video Aspect: 16:9")
                            .foregroundColor(.mint)
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
                            .foregroundColor(.mint)
                        Text("Video Digital Lens: Linear")
                            .foregroundColor(.mint)
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
                            .foregroundColor(.indigo)
                        Text("Anti Flicker: 60Hz")
                            .foregroundColor(.indigo)
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
                            .foregroundColor(.indigo)
                        Text("Hypersmooth: Off")
                            .foregroundColor(.indigo)
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
                            .foregroundColor(.pink)
                        Text("System Video Bit Rate: High")
                            .foregroundColor(.pink)
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
                            .foregroundColor(.pink)
                        Text("System Video Bit Depth: 10bit")
                            .foregroundColor(.pink)
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
                            .foregroundColor(.teal)
                        Text("Auto Power Down: Never")
                            .foregroundColor(.teal)
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
                            .foregroundColor(.teal)
                        Text("Controls Mode: Pro")
                            .foregroundColor(.teal)
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
        SettingsView()
    }
}
