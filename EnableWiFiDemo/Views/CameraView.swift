/* CameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraView.swift
//  EnableWiFiDemo
//

import SwiftUI
import os.log

struct CameraView: View {
    var cameraSerialNumber: String
    @State private var camera: GoPro?
    @State private var mediaEndPointList: [String]?
    @State private var cameraInfo: CameraInfo?
    var body: some View {
        VStack(content: {
            Divider().padding()
            HStack {
                VStack {
                    Text("Model Name")
                        .foregroundColor(.orange)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Divider()
                    Text(cameraInfo?.model_name ?? "")
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                VStack {
                    Text("Serial Number")
                        .foregroundColor(.orange)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Divider()
                    Text(cameraInfo?.serial_number ?? "")
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                VStack {
                    Text("AP SSID")
                        .foregroundColor(.orange)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Divider()
                    Text(cameraInfo?.ap_ssid ?? "")
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                VStack {
                    Text("Firmware Version")
                        .foregroundColor(.orange)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                    Divider()
                    Text(cameraInfo?.firmware_version ?? "")
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
            }
            Divider().padding()
            HStack {
                Button(action: {
                    os_log("Shutter On", type: .info)
                    camera?.requestUsbCommand(command: .shutterOn) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                    }
                }, label: {
                    VStack {
                        Image(systemName: "video")
                            .foregroundColor(.cyan)
                            .padding([.top, .bottom], 7)
                            .padding([.leading, .trailing], 10)
                        Text("Shutter On")
                            .foregroundColor(.cyan)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                    }
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                Button(action: {
                    os_log("Shutter Off", type: .info)
                    camera?.requestUsbCommand(command: .shutterOff) {error in
                        if error != nil {
                            os_log("Error: %@", type: .error, error! as CVarArg)
                            return
                        }
                        // refresh media list
                    }
                }, label: {
                    VStack {
                        Image(systemName: "stop")
                            .foregroundColor(.pink)
                            .padding([.top, .bottom], 7)
                            .padding([.leading, .trailing], 10)
                        Text("Shutter Off")
                            .foregroundColor(.pink)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                    }
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                Button(action: {
                    os_log("Get Media All", type: .info)
                    for mediaUrl in mediaEndPointList ?? [] {
                        self.camera?.requestUsbMediaDownload(mediaEndPoint: mediaUrl) { progress, error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                }, label: {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.green)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                        Text("Get Media All")
                            .foregroundColor(.green)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                    }
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
                Button(action: {
                    os_log("Remove Media All", type: .info)
                    for mediaUrl in mediaEndPointList ?? [] {
                        self.camera?.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                            // refresh media list
                        }
                    }
                }, label: {
                    VStack {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                        Text("Remove Media All")
                            .foregroundColor(.red)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                    }
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1.0)
                )
                .padding()
            }
            Divider().padding()
            Text("Media List").padding()
            List {
                ForEach(mediaEndPointList ?? [], id: \.self) { mediaEndPoint in
                    Button(action: {
                        os_log("Download Media: %@", type: .info, mediaEndPoint)
                        self.camera?.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }, label: {
                        HStack() {
                            Spacer()
                            Image(systemName: "photo")
                                .foregroundColor(.teal)
                            Text(mediaEndPoint)
                                .foregroundColor(.teal)
                            Spacer()
                        }
                    })
                }
                .onDelete(perform: deleteMediaItem)
                .listRowSeparator(.hidden)
            }
        })
        .onAppear {
            self.camera = GoPro(serialNumber: cameraSerialNumber)

            os_log("Get camera info: GoPro %@", type: .info, cameraSerialNumber)
            self.camera?.requestUsbCameraInfo { cameraInfo, error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
                self.cameraInfo = cameraInfo
            }

            os_log("Enable Wired USB Control: GoPro %@", type: .info, cameraSerialNumber)
            self.camera?.requestUsbCommand(command: .enableWiredUsbControl) { error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
            }

            os_log("Get media list: GoPro %@", type: .info, cameraSerialNumber)
            self.camera?.requestUsbMediaList { mediaEndPointList, error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
                self.mediaEndPointList = mediaEndPointList
            }
        }
        .onDisappear {
            self.camera = nil
            os_log("Remove camera instance: GoPro %@", type: .info, cameraSerialNumber)
        }
    }

    private func deleteMediaItem(at offsets: IndexSet) {
        let cameraMediaEndPoint = mediaEndPointList?[offsets.first!]
        camera?.requestUsbMediaRemove(mediaEndPoint: cameraMediaEndPoint ?? "") { error in
            if error != nil {
                os_log("Error: %@", type: .error, error! as CVarArg)
                return
            }
            self.mediaEndPointList?.remove(atOffsets: offsets)
        }
        self.mediaEndPointList?.remove(atOffsets: offsets)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(cameraSerialNumber: "")
    }
}
