/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  EnableWiFiDemo
//

import SwiftUI
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
                    }, label: {
                        VStack {
                            HStack {
                                Image(systemName: "video")
                                Image(systemName: "a.circle")
                            }
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
                        os_log("Shutter Off All", type: .info)
                        for cameraConnectionInfo in cameraConnectionInfoList.filter({ $0.isConnected == true }) {
                            cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOff) {error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    return
                                }
                            }
                        }
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

                                for mediaUrl in mediaEndPointList ?? [] {
                                    cameraConnectionInfo.camera.requestUsbMediaDownload(mediaEndPoint: mediaUrl) { progress, error in
                                        if error != nil {
                                            os_log("Error: %@", type: .error, error! as CVarArg)
                                            return
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
                        if newCameraSerialNumber.count == 3 && newCameraSerialNumber.isInt() && cameraConnectionInfoList.filter({ $0.camera.serialNumber != newCameraSerialNumber }).count == 0 {
                            os_log("Add GoPro %@", type: .info, newCameraSerialNumber)
                            cameraConnectionInfoList.append(CameraConnectionInfo(camera: GoPro(serialNumber: newCameraSerialNumber)))

                            os_log("Enable Wired USB Control: GoPro %@", type: .info, cameraConnectionInfoList[-1].camera.serialNumber)
                            cameraConnectionInfoList[-1].camera.requestUsbCameraInfo { cameraInfo, error in
                                if error != nil {
                                    os_log("Error: %@", type: .error, error! as CVarArg)
                                    cameraConnectionInfoList[-1].isConnected = false
                                    return
                                }
                                cameraConnectionInfoList[-1].isConnected = true
                                cameraConnectionInfoList[-1].camera.requestUsbCommand(command: .enableWiredUsbControl) { error in
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
                                os_log("Reconnect: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                                if let index = cameraConnectionInfoList.firstIndex(of: cameraConnectionInfo) {
                                    connectCameraItem(index: index)
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
                }
            }
            .onAppear {
                for idx in 0 ..< cameraConnectionInfoList.count {
                    connectCameraItem(index: idx)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Multi Camera Control").fontWeight(.bold)
                }
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

    private func connectCameraItem(index: Int) {
        os_log("Connect GoPro %@", type: .info, cameraConnectionInfoList[index].camera.serialNumber)
        cameraConnectionInfoList[index].camera.requestUsbCameraInfo { cameraInfo, error in
            if error != nil {
                os_log("Error: %@", type: .error, error! as CVarArg)
                cameraConnectionInfoList[index].isConnected = false
                return
            }
            cameraConnectionInfoList[index].isConnected = true

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
