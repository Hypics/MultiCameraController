/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  EnableWiFiDemo
//

import SwiftUI
import os.log

struct MultiCameraView: View {
    @State private var showSettingsView = false
    @State private var showCameraView = false
    @State private var cameraSerialNumberList: [String] = ["123", "317"]
    @State private var targetCameraSerialNumber: String = ""
    @State private var newCameraSerialNumber: String = ""
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SettingsView(cameraSerialNumberList: cameraSerialNumberList), isActive: $showSettingsView) { EmptyView() }
                NavigationLink(destination: CameraView(cameraSerialNumber: targetCameraSerialNumber), isActive: $showCameraView) { EmptyView() }
                Divider().padding()
                HStack() {
                    Button(action: {
                        os_log("Shutter On All", type: .info)
                    }, label: {
                        VStack {
                            Image(systemName: "video")
                                .foregroundColor(.cyan)
                                .padding([.top, .bottom], 7)
                                .padding([.leading, .trailing], 10)
                            Text("Shutter On All")
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
                    }, label: {
                        VStack {
                            Image(systemName: "stop")
                                .foregroundColor(.pink)
                                .padding([.top, .bottom], 7)
                                .padding([.leading, .trailing], 10)
                            Text("Shutter Off All")
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
                    Button(action: {
                        os_log("SettingsView", type: .info)
                        showSettingsView = true
                    }, label: {
                        VStack {
                            Image(systemName: "gear")
                                .foregroundColor(.orange)
                                .padding([.top, .bottom], 5)
                                .padding([.leading, .trailing], 10)
                            Text("Settings All")
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
                        if newCameraSerialNumber.count == 3 && newCameraSerialNumber.isInt() && !cameraSerialNumberList.contains(newCameraSerialNumber) {
                            os_log("Add GoPro %@", type: .info, newCameraSerialNumber)
                            cameraSerialNumberList.append(newCameraSerialNumber)
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
                    ForEach(cameraSerialNumberList, id: \.self) { cameraSerialNumber in
                        Button(action: {
                            os_log("CameraView: GoPro %@", type: .info, cameraSerialNumber)
                            targetCameraSerialNumber = cameraSerialNumber
                            showCameraView = true
                        }, label: {
                            HStack() {
                                Spacer()
                                Image(systemName: "camera")
                                    .foregroundColor(.teal)
                                Text("GoPro " + cameraSerialNumber)
                                    .foregroundColor(.teal)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .renderingMode(.template)
                                    .foregroundColor(.teal)
                            }
                        })
                    }
                    .onDelete(perform: deleteCameraItem)
                    .onMove(perform: moveCameraItem)
                    .onLongPressGesture {
                        withAnimation {
                            self.isCameraSerialNumberListEditable = true
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .environment(\.editMode, isCameraSerialNumberListEditable ? .constant(.active) : .constant(.inactive))
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
            os_log("Remove GoPro %@", type: .info, cameraSerialNumberList[offsets.first!])
        cameraSerialNumberList.remove(atOffsets: offsets)
    }

    private func moveCameraItem(from source: IndexSet, to destination: Int) {
            os_log("Move GoPro %@", type: .info, cameraSerialNumberList[source.first!])
        cameraSerialNumberList.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isCameraSerialNumberListEditable = false
        }
    }
}

struct MultiCameraView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCameraView()
    }
}
