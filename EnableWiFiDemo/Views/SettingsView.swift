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
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Text("4K@120FPS, 16:9, Linear")
                    Text("60Hz, Off, High, 10bit, Never, Pro")
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
            })
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1.0)
            )
            Divider().padding()
            List {
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "camera")
                        Text("Video Resolution: 4K")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Video Resolution: 4K", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.on.rectangle")
                        Text("Video FPS: 120Hz")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Video FPS: 120Hz", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "aspectratio")
                        Text("Video Aspect: 16:9")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Video Aspect: 16:9", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "field.of.view.wide")
                        Text("Video Digital Lens: Linear")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Video Digital Lens: Linear", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "warninglight")
                        Text("Anti Flicker: 60Hz")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Anti Flicker: 60Hz", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "circle.and.line.horizontal")
                        Text("Hypersmooth: Off")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Hypersmooth: Off", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                        Text("System Video Bit Rate: High")
                        Spacer()

                    }
                    Button(action: {
                        os_log("System Video Bit Rate: High", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "slider.vertical.3")
                        Text("System Video Bit Depth: 10bit")
                        Spacer()

                    }
                    Button(action: {
                        os_log("System Video Bit Depth: 10bit", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "powersleep")
                        Text("Auto Power Down: Never")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Auto Power Down: Never", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
                .listRowSeparator(.hidden)
                ZStack {
                    HStack {
                        Spacer()
                        Image(systemName: "wrench.and.screwdriver")
                        Text("Controls Mode: Pro")
                        Spacer()

                    }
                    Button(action: {
                        os_log("Controls Mode: Pro", type: .info)
                    }, label: {
                        EmptyView()
                    })
                }
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
