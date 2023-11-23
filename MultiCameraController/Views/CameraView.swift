/* CameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraView.swift
//  MultiCameraController
//

import SwiftUI
import AlertToast
import os.log

struct CameraView: View {
    var camera: GoPro
    @State private var cameraInfo: CameraInfo?
    @State private var mediaEndPointList: [String] = []
    @State private var downloadMediaUrl: String = ""
    @State private var downloadProgress: Double = 0.0

    @State private var showSutterOnToast = false
    @State private var showSutterOffToast = false
    @State private var showDownloadMediaToast = false
    @State private var showRemoveMediaToast = false
    @State private var showRefreshMediaListToast = false
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
                    camera.requestUsbCommand(command: .shutterOn) {error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                    }
                    showSutterOnToast.toggle()
                }, label: {
                    VStack {
                        Image(systemName: "video")
                            .foregroundColor(.teal)
                            .padding([.top, .bottom], 7)
                            .padding([.leading, .trailing], 10)
                        Text("Shutter On")
                            .foregroundColor(.teal)
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
                    camera.requestUsbCommand(command: .shutterOff) {error in
                        if error != nil {
                            os_log("Error: %@", type: .error, error! as CVarArg)
                            return
                        }
                    }
                    showSutterOffToast.toggle()
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
                    os_log("Download Media All", type: .info)
                    for mediaEndPoint in mediaEndPointList {
                        showDownloadMediaToast = true
                        self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                            if let progress = progress {
                                if progress > 99.9 {
                                    showDownloadMediaToast = false
                                }
                                self.downloadMediaUrl = mediaEndPoint
                                self.downloadProgress = progress
                            }
                        }
                    }
                }, label: {
                    VStack {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                            Image(systemName: "a.circle")
                        }
                        .foregroundColor(.green)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                        Text("Download Media")
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
                    for mediaUrl in mediaEndPointList {
                        self.camera.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                        }
                    }
                    showRemoveMediaToast.toggle()
                }, label: {
                    VStack {
                        HStack {
                            Image(systemName: "trash")
                            Image(systemName: "a.circle")
                        }
                        .foregroundColor(.red)
                        .padding([.top, .bottom], 5)
                        .padding([.leading, .trailing], 10)
                        Text("Remove Media")
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
                ForEach(mediaEndPointList, id: \.self) { mediaEndPoint in
                    Button(action: {
                        os_log("Download Media: %@", type: .info, mediaEndPoint)
                        showDownloadMediaToast = true
                        self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                            if error != nil {
                                os_log("Error: %@", type: .error, error! as CVarArg)
                                return
                            }
                            if let progress = progress {
                                if progress > 99.9 {
                                    showDownloadMediaToast = false
                                }
                                self.downloadMediaUrl = mediaEndPoint
                                self.downloadProgress = progress
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
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button(action: {
                            os_log("Download Media: %@", type: .info, mediaEndPoint)
                            showDownloadMediaToast = true
                            self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }
                                if let progress = progress {
                                    if progress > 99.9 {
                                        showDownloadMediaToast = false
                                    }
                                    self.downloadMediaUrl = mediaEndPoint
                                    self.downloadProgress = progress
                                }
                            }
                        }, label: {
                            Text("Download")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        })
                        .tint(.green)
                    }
                }
                .onDelete(perform: deleteMediaItem)
                .listRowSeparator(.hidden)
            }
            .refreshable {
                os_log("Download media list: GoPro %@", type: .info, self.camera.serialNumber)
                self.camera.requestUsbMediaList { mediaEndPointList, error in
                    if error != nil {
                        os_log("Error: %@", type: .error, error! as CVarArg)
                        return
                    }
                    self.mediaEndPointList = mediaEndPointList ?? []
                }
                showRefreshMediaListToast.toggle()
            }
        })
        .onAppear {
            os_log("Get camera info: GoPro %@", type: .info, camera.serialNumber)
            self.camera.requestUsbCameraInfo { cameraInfo, error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
                self.cameraInfo = cameraInfo
            }

            os_log("Download media list: GoPro %@", type: .info, camera.serialNumber)
            self.camera.requestUsbMediaList { mediaEndPointList, error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
                self.mediaEndPointList = mediaEndPointList ?? []
            }
        }
        .toast(isPresenting: $showSutterOnToast, duration: 1, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .systemImage("video", .teal), title: "Shutter On : GoPro \(camera.serialNumber)", style: .style(titleColor: .teal))
        }
        .toast(isPresenting: $showSutterOffToast, duration: 1, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .systemImage("stop", .pink), title: "Shutter Off : GoPro \(camera.serialNumber)", style: .style(titleColor: .pink))
        }
        .toast(isPresenting: $showDownloadMediaToast) {
            AlertToast(type: .loading, title: self.downloadMediaUrl, subTitle: String(describing: self.downloadProgress) + " %")
        }
        .toast(isPresenting: $showRemoveMediaToast, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .systemImage("trash", .red), title: "GoPro \(camera.serialNumber): \(String(describing: mediaEndPointList.count)) files", style: .style(titleColor: .red))
        }
        .toast(isPresenting: $showRefreshMediaListToast, duration: 1, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .systemImage("photo", .teal), title: "GoPro \(camera.serialNumber): \(String(describing: mediaEndPointList.count)) files", style: .style(titleColor: .teal))
        }
    }

    private func deleteMediaItem(at offsets: IndexSet) {
        camera.requestUsbMediaRemove(mediaEndPoint: mediaEndPointList[offsets.first!]) { error in
            if error != nil {
                os_log("Error: %@", type: .error, error! as CVarArg)
                return
            }
            self.mediaEndPointList.remove(atOffsets: offsets)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(camera: GoPro(serialNumber: ""))
    }
}
