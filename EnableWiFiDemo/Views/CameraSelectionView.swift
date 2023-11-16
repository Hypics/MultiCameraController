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
    @State private var showCameraView = false
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CameraView(peripheral: peripheral), isActive: $showCameraView) { EmptyView() }
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
                                os_log("Connecting to %@..", type: .info, peripheral.name)
                                peripheral.secureConnect { error in
                                    if error != nil {
                                        os_log("Error connecting to %@", type: .error, peripheral.name)
                                        return
                                    }
                                    if self.peripheral == nil {
                                        os_log("Connected to %@!", type: .info, peripheral.name)
                                        self.peripheral = peripheral
                                        showCameraView = true
                                    } else {
                                        os_log("self.peripheral is remained!", type: .debug)
                                    }
                                }
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
}

struct CameraSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CameraSelectionView()
    }
}
