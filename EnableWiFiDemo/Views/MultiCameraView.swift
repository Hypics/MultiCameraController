/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  EnableWiFiDemo
//

import SwiftUI
import AlertToast
import os.log

struct CameraConnectionInfo: Hashable {
    var camera: GoPro
    var isConnected: Bool = false
}

struct MultiCameraView: View {
    @State private var showSettingsView = false
    @State private var showCameraView = false
    @State private var cameraConnectionInfoList: [CameraConnectionInfo] = [CameraConnectionInfo(camera: GoPro(serialNumber: "123")), CameraConnectionInfo(camera: GoPro(serialNumber: "317"))]
    @State private var isCameraConnectionInfoListEditable = false
    @State private var targetCameraConnectionInfo: CameraConnectionInfo = CameraConnectionInfo(camera: GoPro(serialNumber: ""))
    @State private var newCameraSerialNumber: String = ""
    @State private var downloadMediaUrl: String = ""
    @State private var downloadProgress: Double = 0.0
    @State private var showCameraToast = false
    @State private var showSutterOnToast = false
    @State private var showSutterOffToast = false
    @State private var showDownloadMediaToast = false
    @State private var showRemoveMediaToast = false
    @State private var showRefreshCameraListToast = false
    @State private var showCameraConnectedToast = false
    @State private var showCameraEmptyToast = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SettingsView(cameraConnectionInfoList: cameraConnectionInfoList.filter({ $0.isConnected == true })), isActive: $showSettingsView) { EmptyView() }
                NavigationLink(destination: CameraView(camera: targetCameraConnectionInfo.camera), isActive: $showCameraView) { EmptyView() }
                Divider().padding()
                HStack {
                    Button(action: {
                        os_log("Shutter On All", type: .info)
                        for cameraConnectionInfo in cameraConnectionInfoList.filter({ $0.isConnected == true }) {
                            cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOn) {error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }
                            }
                        }
                        showSutterOnToast.toggle()
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "video")
                                Image(systemName: "a.circle")
                            }
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
                        os_log("Shutter Off All", type: .info)
                        for cameraConnectionInfo in cameraConnectionInfoList.filter({ $0.isConnected == true }) {
                            cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOff) {error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }
                            }
                        }
                        showSutterOffToast.toggle()
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "stop")
                                Image(systemName: "a.circle")
                            }
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
                        for cameraConnectionInfo in cameraConnectionInfoList.filter({ $0.isConnected == true }) {
                            os_log("Download media list: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                            cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }

                                for mediaEndPoint in mediaEndPointList ?? [] {
                                    showDownloadMediaToast = true
                                    cameraConnectionInfo.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
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
                            }
                        }
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "photo.on.rectangle.angled")
                                Image(systemName: "a.circle")
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
                        for cameraConnectionInfo in cameraConnectionInfoList.filter({ $0.isConnected == true }) {
                            os_log("Remove media list: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                            cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }

                                for mediaUrl in mediaEndPointList ?? [] {
                                    cameraConnectionInfo.camera.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
                                        if error != nil {
                                            os_log("Error: %@", type: .error, error! as CVarArg)
                                            return
                                        }
                                    }
                                }
                            }
                        }
                        showRemoveMediaToast.toggle()
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "trash")
                                Image(systemName: "a.circle")
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
                    Button(action: {
                        os_log("SettingsView", type: .info)
                        showSettingsView = true
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "gear")
                                Image(systemName: "a.circle")
                            }
                            .foregroundColor(.orange)
                            .padding([.top, .bottom], 5)
                            .padding([.leading, .trailing], 10)
                            Text("Settings")
                                .foregroundColor(.orange)
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
                Text("GoPro List").padding()
                HStack {
                    TextField("GoPro Serial Number (last 3 digits)", text: $newCameraSerialNumber)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray, lineWidth: 1.0)
                        )
                        .padding()
                    Button(action: {
                        if newCameraSerialNumber.count == 3 && newCameraSerialNumber.isInt() && cameraConnectionInfoList.filter({ $0.camera.serialNumber == newCameraSerialNumber }).count == 0 {
                            os_log("Add GoPro %@", type: .info, newCameraSerialNumber)
                            cameraConnectionInfoList.append(CameraConnectionInfo(camera: GoPro(serialNumber: newCameraSerialNumber)))

                            let index = cameraConnectionInfoList.count - 1
                            os_log("Enable Wired USB Control: GoPro %@", type: .info, cameraConnectionInfoList[index].camera.serialNumber)
                            cameraConnectionInfoList[index].camera.requestUsbCameraInfo { cameraInfo, error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    if index >= cameraConnectionInfoList.count {
                                        return
                                    }
                                    cameraConnectionInfoList[index].isConnected = false
                                    return
                                }

                                if index >= cameraConnectionInfoList.count {
                                    return
                                }
                                cameraConnectionInfoList[index].isConnected = true
                                cameraConnectionInfoList[index].camera.requestUsbCommand(command: .enableWiredUsbControl) { error in
                                    if error != nil {
                                        os_log("Error: %@", type: .error, error! as CVarArg)
                                        return
                                    }
                                }
                            }
                        } else {
                            os_log("%@ is not a serial number (3 digits)", type: .error, newCameraSerialNumber)
                        }
                    }, label: {
                        VStack() {
                            Image(systemName: "plus.square")
                                .foregroundColor(.orange)
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Add Camera")
                                .foregroundColor(.orange)
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
                Divider()
                List{
                    ForEach(cameraConnectionInfoList, id: \.self) { cameraConnectionInfo in
                        Button(action: {
                            if cameraConnectionInfo.isConnected {
                                os_log("CameraView: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                                targetCameraConnectionInfo = cameraConnectionInfo
                                showCameraView = true
                            } else {
                                os_log("CameraView is not connected: GoPro %@", type: .error, cameraConnectionInfo.camera.serialNumber)
                                showCameraEmptyToast.toggle()
                            }
                        }, label: {
                            HStack() {
                                Spacer()
                                if cameraConnectionInfo.isConnected {
                                    Image(systemName: "camera")
                                        .foregroundColor(.teal)
                                    Text("GoPro " + cameraConnectionInfo.camera.serialNumber)
                                        .foregroundColor(.teal)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .renderingMode(.template)
                                        .foregroundColor(.teal)
                                } else {
                                    Image(systemName: "camera")
                                        .foregroundColor(.pink)
                                    Text("GoPro " + cameraConnectionInfo.camera.serialNumber)
                                        .foregroundColor(.pink)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .renderingMode(.template)
                                        .foregroundColor(.pink)
                                }
                            }
                        })
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                os_log("Connect: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                                if let index = cameraConnectionInfoList.firstIndex(of: cameraConnectionInfo) {
                                    connectCameraItem(index: index, showToast: true)
                                }
                            }, label: {
                                Text("Connect")
                                    .padding([.top, .bottom], 5)
                                    .padding([.leading, .trailing], 10)
                            })
                            .tint(.teal)
                        }
                    }
                    .onDelete(perform: deleteCameraItem)
                    .onMove(perform: moveCameraItem)
                    .onLongPressGesture {
                        withAnimation {
                            self.isCameraConnectionInfoListEditable = true
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .environment(\.editMode, isCameraConnectionInfoListEditable ? .constant(.active) : .constant(.inactive))
                .refreshable {
                    for idx in 0 ..< cameraConnectionInfoList.count {
                        connectCameraItem(index: idx)
                    }
                    showRefreshCameraListToast.toggle()
                }
            }
            .onAppear {
                for idx in 0 ..< cameraConnectionInfoList.count {
                    connectCameraItem(index: idx)
                }
                showCameraToast.toggle()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Multi Camera Control").fontWeight(.bold)
                }
            }
            .toast(isPresenting: $showCameraToast, duration: 3, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("camera", .primary), title: "Connected : \(cameraConnectionInfoList.filter({ $0.isConnected == true }).count) cams", style: .style(titleColor: .primary))
            }
            .toast(isPresenting: $showSutterOnToast, duration: 1, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("video", .teal), title: "Shutter On All : \(cameraConnectionInfoList.filter({ $0.isConnected == true }).count) cams", style: .style(titleColor: .teal))
            }
            .toast(isPresenting: $showSutterOffToast, duration: 1, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("stop", .pink), title: "Shutter Off All : \(cameraConnectionInfoList.filter({ $0.isConnected == true }).count) cams", style: .style(titleColor: .pink))
            }
            .toast(isPresenting: $showDownloadMediaToast) {
                AlertToast(type: .loading, title: self.downloadMediaUrl, subTitle: String(describing: self.downloadProgress) + " %")
            }
            .toast(isPresenting: $showRemoveMediaToast, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("trash", .red), title: "Remove Media All : \(cameraConnectionInfoList.filter({ $0.isConnected == true }).count) cams", style: .style(titleColor: .red))
            }
            .toast(isPresenting: $showRefreshCameraListToast, duration: 1, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("camera", .teal), title: "Refresh Camera List : \(cameraConnectionInfoList.filter({ $0.isConnected == true }).count) cams", style: .style(titleColor: .teal))
            }
            .toast(isPresenting: $showCameraConnectedToast, duration: 1, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("camera", .teal), title: "Success : Camera is connected", style: .style(titleColor: .teal))
            }
            .toast(isPresenting: $showCameraEmptyToast, duration: 1, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("camera", .pink), title: "Fail : Camera is not connected", style: .style(titleColor: .pink))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func deleteCameraItem(at offsets: IndexSet) {
        os_log("Remove GoPro %@", type: .info, cameraConnectionInfoList[offsets.first!].camera.serialNumber)
        cameraConnectionInfoList.remove(atOffsets: offsets)
    }

    private func moveCameraItem(from source: IndexSet, to destination: Int) {
        os_log("Move GoPro %@", type: .info, cameraConnectionInfoList[source.first!].camera.serialNumber)
        cameraConnectionInfoList.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isCameraConnectionInfoListEditable = false
        }
    }

    private func connectCameraItem(index: Int, showToast: Bool = false) {
        os_log("Connect GoPro %@", type: .info, cameraConnectionInfoList[index].camera.serialNumber)
        cameraConnectionInfoList[index].camera.requestUsbCameraInfo { cameraInfo, error in
            if error != nil {
                os_log("Error: %@", type: .error, error! as CVarArg)
                cameraConnectionInfoList[index].isConnected = false
                if showToast {
                    showCameraEmptyToast.toggle()
                }
                return
            }
            cameraConnectionInfoList[index].isConnected = true
            if showToast {
                showCameraConnectedToast.toggle()
            }

            os_log("Enable Wired USB Control: GoPro %@", type: .info, cameraConnectionInfoList[index].camera.serialNumber)
            cameraConnectionInfoList[index].camera.requestUsbCommand(command: .enableWiredUsbControl) { error in
                if error != nil {
                    os_log("Error: %@", type: .error, error! as CVarArg)
                    return
                }
            }
        }
    }
}

struct MultiCameraView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCameraView()
    }
}
