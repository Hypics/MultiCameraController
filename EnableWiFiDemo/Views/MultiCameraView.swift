/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  EnableWiFiDemo
//

import SwiftUI
import CoreBluetooth
import os.log

struct MultiCameraView: View {
    @ObservedObject var scanner = CentralManager()
    @State private var peripheral: Peripheral?
    @State private var showSettingsView = false
    @State private var showCameraView = false
    @State private var mediaUrlList: [String] = []
    @State private var cameraList: [String] = ["123", "317"]
    @State private var new_camera: String = ""
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SettingsView(), isActive: $showSettingsView) { EmptyView() }
                NavigationLink(destination: CameraView(peripheral: peripheral), isActive: $showCameraView) { EmptyView() }
                Divider().padding()
                HStack() {
                    Button(action: {
                        os_log("Shutter On All", type: .info)
                    }, label: {
                        VStack {
                            Image(systemName: "video")
                                .padding([.top, .bottom], 7)
                                .padding([.leading, .trailing], 10)
                            Text("Shutter On All")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    Button(action: {
                        os_log("Shutter Off All", type: .info)
                    }, label: {
                        VStack {
                            Image(systemName: "stop")
                                .padding([.top, .bottom], 7)
                                .padding([.leading, .trailing], 10)
                            Text("Shutter Off All")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    Button(action: {
                        os_log("Get Media All", type: .info)
                    }, label: {
                        VStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Get Media All")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    Button(action: {
                        os_log("Remove Media All", type: .info)
                    }, label: {
                        VStack {
                            Image(systemName: "trash")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Remove Media All")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    Button(action: {
                        os_log("SettingsView", type: .info)
                        showSettingsView = true
                    }, label: {
                        VStack {
                            Image(systemName: "gear")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Settings All")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                }
                Divider().padding()
                Text("GoPro List").padding()
                HStack {
                    TextField("GoPro Serial Number", text: $new_camera)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1.0)
                        )
                        .padding()
                    Button(action: {
                        os_log("Add Camera", type: .info)
                        cameraList.append(new_camera)
                    }, label: {
                        VStack() {
                            Image(systemName: "plus.square")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Add Camera")
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                        }
                    })
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1.0)
                    )
                    .padding()
                }
                Divider()
                List{
                    ForEach(cameraList, id: \.self) { camera in
                        ZStack {
                            HStack() {
                                Spacer()
                                Image(systemName: "camera")
                                Text("GoPro " + camera)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                                
                            }
                            Button(action: {
                                os_log("CameraView: GoPro %@", type: .info, camera)
                                showCameraView = true
                            }, label: {
                                EmptyView()
                            })
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .listRowSeparator(.hidden)
                }
                // End
                Button(action: {
                    os_log("Requesting Media List...", type: .info)
                    Peripheral.requestWiFiCommand(serialNumber: 317, command: .get_media_list, { (mediaUrlList, error) in
                        if error != nil {
                            os_log("Error: %@", type: .error, error! as CVarArg)
                            return
                        }
                        self.mediaUrlList = mediaUrlList
                    })
                }, label: {
                    Text("Get Media List")
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(peripheral?.name ?? "").fontWeight(.bold)
                    }
                }.padding()
                List{
                    ForEach(mediaUrlList, id: \.self) { mediaUrl in
                        ZStack {
                            HStack() {
                                Text(mediaUrl)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                            }
                            Button(action: {
                                os_log("Download %@..", type: .info, mediaUrl)
                                Peripheral.requestDownloadMedia(serialNumber: 317, endPoint: mediaUrl)
                            }, label: {
                                EmptyView()
                            })
                        }
                    }
                }
                Divider()
                Text("Bluetooth").padding()
                List {
                    ForEach(scanner.peripherals, id: \.self) { peripheral in
                        ZStack {
                            HStack() {
                                Text(peripheral.name)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .renderingMode(.template)
                                    .foregroundColor(.gray)
                            }
                            Button(action: {
                                os_log("[1st] Connecting to %@..", type: .info, peripheral.name)
                                secureConnect(with: peripheral)
                            }, label: {
                                EmptyView()
                            })
                        }
                    }
                }
            }
            .onAppear {
                if let peripheral = peripheral {
                    os_log("Disconnecting to %@..", type: .info, peripheral.name)
                    peripheral.disconnect()
                    self.peripheral = nil
                }
                os_log("Scanning for GoPro cameras..", type: .info)
                scanner.start(withServices: [CBUUID(string: "FEA6")])
            }
            .onDisappear { scanner.stop() }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Multi Camera Control").fontWeight(.bold)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func secureConnect(with peripheral: Peripheral) {
        let peripheral_name = peripheral.name
        peripheral.connect { error in
            if error != nil {
                os_log("Error: %@", type: .error, error! as CVarArg)
                return
            }
            self.peripheral = peripheral
            os_log("Stop scanning", type: .info)
            scanner.stop()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let peripheral = self.peripheral {
                    os_log("Disconnecting to %@..", type: .info, peripheral.name)
                    peripheral.disconnect()
                    self.peripheral = nil
                }
                os_log("Scanning for GoPro cameras..", type: .info)
                scanner.start(withServices: [CBUUID(string: "FEA6")])

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let new_peripheral = scanner.peripherals.filter({$0.name == peripheral_name}).first
                    os_log("[2nd] Connecting to %@..", type: .info, new_peripheral?.name ?? "")
                    new_peripheral?.connect { error in
                        if error != nil {
                            os_log("Error: %@", type: .error, error! as CVarArg)
                            return
                        }
                        os_log("Connected to %@", type: .info, new_peripheral?.name ?? "")
                        self.peripheral = new_peripheral
                        showCameraView = true
                    }
                }
            }
        }
    }

    private func deleteItem(at offsets: IndexSet) {
        cameraList.remove(atOffsets: offsets)
    }
}

struct MultiCameraView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCameraView()
    }
}
