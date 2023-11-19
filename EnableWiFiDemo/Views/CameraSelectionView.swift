/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  EnableWiFiDemo
//

import SwiftUI
import CoreBluetooth
import os.log

struct CameraSelectionView: View {
    @ObservedObject var scanner = CentralManager()
    @State private var peripheral: Peripheral?
    @State private var showCameraBleView = false
    @State private var mediaUrlList: [String] = []
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CameraBleView(peripheral: peripheral), isActive: $showCameraBleView) { EmptyView() }
                Text("USB").padding()
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
                    Text("Select Camera").fontWeight(.bold)
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
                        showCameraBleView = true
                    }
                }
            }
        }
    }
}

struct CameraSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CameraSelectionView()
    }
}
