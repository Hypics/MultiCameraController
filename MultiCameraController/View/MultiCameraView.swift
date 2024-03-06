/* MultiCameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  MultiCameraView.swift
//  MultiCameraController
//

import AlertToast
import Foundation
import os.log
import SwiftUI

struct MultiCameraView: View {
  @StateObject var multiCameraViewModel = MultiCameraViewModel()
  @StateObject var dataServerViewModel = DataServerViewModel()

  @State private var showSettingView = false
  @State private var showCameraView = false

  @State private var targetCameraConnectionInfo = CameraConnectionInfo(camera: GoPro(serialNumber: ""))
  @State private var newCameraSerialNumber: String = ""
  @State private var downloadMediaUrl: String = ""
  @State private var downloadProgress: Double = 0.0

  @State private var showCameraToast = false
  @State private var showShutterOnToast = false
  @State private var showShutterOffToast = false
  @State private var showDownloadMediaToast = false
  @State private var showRemoveMediaToast = false
  @State private var showRefreshCameraListToast = false
  @State private var showCameraConnectedToast = false
  @State private var showCameraEmptyToast = false
  var body: some View {
    NavigationStack {
      VStack {
        Divider()
          .padding([.top, .bottom], 5)
        LoginView(dataServerViewModel: self.dataServerViewModel)
        Divider()
          .padding([.top, .bottom], 5)
        HStack {
          Spacer()
          Spacer()
          Button(action: {
            os_log("Shutter On All", type: .info)
            for cameraConnectionInfo in self.multiCameraViewModel.getConnectedCameraList() {
              cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOn) { error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                  return
                }
              }
            }
            self.showShutterOnToast.toggle()
          }, label: {
            VStack {
              HStack {
                Image(systemName: "video")
                Image(systemName: "a.circle")
              }
              .foregroundColor(.teal)
              .padding([.top, .bottom], 2)
              Text("Shutter On")
                .foregroundColor(.teal)
            }
          })
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding([.top, .bottom], 5)
          .padding([.leading, .trailing], 3)
          Spacer()
          Button(action: {
            os_log("Shutter Off All", type: .info)
            for cameraConnectionInfo in self.multiCameraViewModel.getConnectedCameraList() {
              cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOff) { error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                  return
                }
              }
            }
            self.showShutterOffToast.toggle()
          }, label: {
            VStack {
              HStack {
                Image(systemName: "stop")
                Image(systemName: "a.circle")
              }
              .foregroundColor(.pink)
              .padding([.top, .bottom], 2)
              Text("Shutter Off")
                .foregroundColor(.pink)
            }
          })
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding([.top, .bottom], 5)
          .padding([.leading, .trailing], 3)
          Spacer()
          Button(action: {
            os_log("Download Media All", type: .info)
            self.getCreationTimestamp { creationTimestamp in
              let creationDate = Date(timeIntervalSince1970: TimeInterval(creationTimestamp))
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "YYMMdd_hhmmss"
              let creationDateString = dateFormatter.string(from: creationDate)
              os_log("creationTimestamp: %@ from %@", type: .info, creationDateString, creationTimestamp.description)
              for cameraConnectionInfo in self.multiCameraViewModel.getConnectedCameraList() {
                os_log(
                  "Download media list: GoPro %@",
                  type: .info,
                  cameraConnectionInfo.camera.serialNumber
                )
                cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, _, error in
                  if error != nil {
                    os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                    return
                  }

                  for mediaEndPoint in mediaEndPointList ?? [] {
                    self.showDownloadMediaToast = true
                    cameraConnectionInfo.camera
                      .requestUsbMediaDownload(
                        mediaEndPoint: mediaEndPoint,
                        timestamp_path: creationDateString
                      ) { progress, error in
                        if error != nil {
                          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                          return
                        }
                        if let progress {
                          if progress > 99.9 {
                            self.showDownloadMediaToast = false
                          }
                          self.downloadMediaUrl = "[GoPro " + cameraConnectionInfo.camera
                            .serialNumber + "] " + (mediaEndPoint.split(separator: "/").last ?? "")
                          self.downloadProgress = progress
                        }
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
              .padding([.top, .bottom], 2)
              Text("Download Media")
                .foregroundColor(.green)
            }
          })
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding([.top, .bottom], 5)
          .padding([.leading, .trailing], 3)
          Spacer()
          Button(action: {
            os_log("Remove Media All", type: .info)
            for cameraConnectionInfo in self.multiCameraViewModel.getConnectedCameraList() {
              os_log("Remove media list: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
              cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, _, error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                  return
                }

                for mediaUrl in mediaEndPointList ?? [] {
                  cameraConnectionInfo.camera
                    .requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
                      if error != nil {
                        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                        return
                      }
                    }
                }
              }
            }
            self.showRemoveMediaToast.toggle()
          }, label: {
            VStack {
              HStack {
                Image(systemName: "trash")
                Image(systemName: "a.circle")
                Image(systemName: "a.circle")
              }
              .foregroundColor(.red)
              .padding([.top, .bottom], 2)
              Text("Remove Media")
                .foregroundColor(.red)
            }
          })
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding([.top, .bottom], 5)
          .padding([.leading, .trailing], 3)
          Spacer()
          Button(action: {
            os_log("SettingView", type: .info)
            self.showSettingView = true
          }, label: {
            VStack {
              HStack {
                Image(systemName: "gear")
                Image(systemName: "a.circle")
              }
              .foregroundColor(.orange)
              .padding([.top, .bottom], 2)
              Text("Setting")
                .foregroundColor(.orange)
            }
          })
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding([.top, .bottom], 5)
          .padding([.leading, .trailing], 3)
          Spacer()
          Spacer()
        }
        Divider()
          .padding([.top, .bottom], 5)
        ZStack {
          HStack {
            Text("GoPro List").padding()
          }
          HStack {
            Spacer()
            TextField("Serial Number (last 3 digits)", text: self.$newCameraSerialNumber)
              .font(.system(size: 13, weight: .bold, design: .rounded))
              .padding(10)
              .overlay(
                RoundedRectangle(cornerRadius: 15)
                  .stroke(.gray, lineWidth: 1.0)
              )
              .frame(width: 200)
              .fixedSize(horizontal: true, vertical: false)
            Button(action: {
              if self.newCameraSerialNumber.count == 3, self.newCameraSerialNumber.isInt(),
                 !self.multiCameraViewModel.cameraConnectionInfoList
                 .contains(where: { $0.camera.serialNumber == newCameraSerialNumber })
              {
                os_log("Add GoPro %@", type: .info, self.newCameraSerialNumber)
                self.multiCameraViewModel.goProSerialNumberList.append(self.newCameraSerialNumber)
                self.multiCameraViewModel.cameraConnectionInfoList
                  .append(CameraConnectionInfo(camera: GoPro(serialNumber: self.newCameraSerialNumber)))

                let index = self.multiCameraViewModel.cameraConnectionInfoList.count - 1
                os_log(
                  "Enable Wired USB Control: GoPro %@",
                  type: .info,
                  self.multiCameraViewModel.cameraConnectionInfoList[index].camera.serialNumber
                )
                self.multiCameraViewModel.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
                  if error != nil {
                    os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                    if index >= self.multiCameraViewModel.cameraConnectionInfoList.count {
                      return
                    }
                    self.multiCameraViewModel.cameraConnectionInfoList[index].isConnected = false
                    return
                  }

                  if index >= self.multiCameraViewModel.cameraConnectionInfoList.count {
                    return
                  }
                  self.multiCameraViewModel.cameraConnectionInfoList[index].isConnected = true
                  self.multiCameraViewModel.cameraConnectionInfoList[index].camera
                    .requestUsbCommand(command: .enableWiredUsbControl) { error in
                      if error != nil {
                        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                        return
                      }
                    }
                }
              } else {
                os_log("%@ is not a serial number (3 digits)", type: .error, self.newCameraSerialNumber)
              }
            }, label: {
              HStack {
                Image(systemName: "plus.square")
                  .foregroundColor(.red)
                Text("Add")
                  .foregroundColor(.red)
              }
            })
            .padding(10)
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding([.leading], 10)
            .padding([.trailing], 15)
          }
        }
        List {
          ForEach(self.multiCameraViewModel.cameraConnectionInfoList, id: \.self) { cameraConnectionInfo in
            Button(action: {
              if cameraConnectionInfo.isConnected {
                os_log("CameraView: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
                self.targetCameraConnectionInfo = cameraConnectionInfo
                self.showCameraView = true
              } else {
                os_log(
                  "CameraView is not connected: GoPro %@",
                  type: .error,
                  cameraConnectionInfo.camera.serialNumber
                )
                self.showCameraEmptyToast.toggle()
              }
            }, label: {
              HStack {
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
                if let index = multiCameraViewModel.cameraConnectionInfoList.firstIndex(of: cameraConnectionInfo) {
                  self.connectCameraItem(index: index, showToast: true)
                }
              }, label: {
                Text("Connect")
                  .padding([.top, .bottom], 5)
                  .padding([.leading, .trailing], 10)
              })
              .tint(.teal)
            }
          }
          .onDelete(perform: self.deleteCameraItem)
          .onMove(perform: self.moveCameraItem)
          .onLongPressGesture {
            withAnimation {
              self.multiCameraViewModel.cameraConnectionInfoListEditable = true
            }
          }
          .listRowSeparator(.hidden)
        }
        .environment(
          \.editMode,
          self.multiCameraViewModel.cameraConnectionInfoListEditable ? .constant(.active) : .constant(.inactive)
        )
        .refreshable {
          for idx in 0 ..< self.multiCameraViewModel.cameraConnectionInfoList.count {
            self.connectCameraItem(index: idx)
          }
          self.showRefreshCameraListToast.toggle()
        }
      }
      .onAppear {
        for idx in 0 ..< self.multiCameraViewModel.cameraConnectionInfoList.count {
          self.connectCameraItem(index: idx)
        }
        self.showCameraToast.toggle()
      }
      .navigationDestination(isPresented: self.$dataServerViewModel.showDataServerView) {
        DataServerView(dataServerViewModel: self.dataServerViewModel)
      }
      .navigationDestination(isPresented: self.$showSettingView) {
        SettingView(
          multiCameraViewModel: self.multiCameraViewModel
        )
      }
      .navigationDestination(isPresented: self.$showCameraView) {
        CameraView(cameraViewModel: CameraViewModel(camera: self.targetCameraConnectionInfo.camera))
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Multi Camera Control").fontWeight(.bold)
        }
      }
      .toast(isPresenting: self.$showCameraToast, duration: 3, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("camera", .primary),
          title: "Connected : \(self.multiCameraViewModel.getConnectedCameraList().count) cams",
          style: .style(titleColor: .primary)
        )
      }
      .toast(isPresenting: self.$showShutterOnToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("video", .teal),
          title: "Shutter On All : \(self.multiCameraViewModel.getConnectedCameraList().count) cams",
          style: .style(titleColor: .teal)
        )
      }
      .toast(isPresenting: self.$showShutterOffToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("stop", .pink),
          title: "Shutter Off All : \(self.multiCameraViewModel.getConnectedCameraList().count) cams",
          style: .style(titleColor: .pink)
        )
      }
      .toast(isPresenting: self.$showDownloadMediaToast) {
        AlertToast(
          type: .loading,
          title: self.downloadMediaUrl,
          subTitle: String(format: "%.2f", self.downloadProgress) + " %"
        )
      }
      .toast(isPresenting: self.$showRemoveMediaToast, duration: 2, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("trash", .red),
          title: "Remove Media All : \(self.multiCameraViewModel.getConnectedCameraList().count) cams",
          style: .style(titleColor: .red)
        )
      }
      .toast(isPresenting: self.$showRefreshCameraListToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("camera", .teal),
          title: "Refresh Camera List : \(self.multiCameraViewModel.getConnectedCameraList().count) cams",
          style: .style(titleColor: .teal)
        )
      }
      .toast(isPresenting: self.$showCameraConnectedToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("camera", .teal),
          title: "Success : Camera is connected",
          style: .style(titleColor: .teal)
        )
      }
      .toast(isPresenting: self.$showCameraEmptyToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("camera", .pink),
          title: "Fail : Camera is not connected",
          style: .style(titleColor: .pink)
        )
      }
      .onChange(of: self.multiCameraViewModel.goProSerialNumberList) {
        UserDefaults.standard.set(self.multiCameraViewModel.goProSerialNumberList, forKey: "GoProSerialNumberList")
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }

  private func deleteCameraItem(at offsets: IndexSet) {
    os_log(
      "Remove GoPro %@",
      type: .info,
      self.multiCameraViewModel.cameraConnectionInfoList[offsets[offsets.startIndex]].camera.serialNumber
    )
    self.multiCameraViewModel.goProSerialNumberList.remove(atOffsets: offsets)
    self.multiCameraViewModel.cameraConnectionInfoList.remove(atOffsets: offsets)
  }

  private func moveCameraItem(from source: IndexSet, to destination: Int) {
    os_log(
      "Move GoPro %@",
      type: .info,
      self.multiCameraViewModel.cameraConnectionInfoList[source[source.startIndex]].camera.serialNumber
    )
    self.multiCameraViewModel.goProSerialNumberList.move(fromOffsets: source, toOffset: destination)
    self.multiCameraViewModel.cameraConnectionInfoList.move(fromOffsets: source, toOffset: destination)
    withAnimation {
      self.multiCameraViewModel.cameraConnectionInfoListEditable = false
    }
  }

  private func connectCameraItem(index: Int, showToast: Bool = false) {
    os_log(
      "Connect GoPro %@",
      type: .info,
      self.multiCameraViewModel.cameraConnectionInfoList[index].camera.serialNumber
    )
    self.multiCameraViewModel.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
        self.multiCameraViewModel.cameraConnectionInfoList[index].isConnected = false
        if showToast {
          self.showCameraEmptyToast.toggle()
        }
        return
      }
      self.multiCameraViewModel.cameraConnectionInfoList[index].isConnected = true
      if showToast {
        self.showCameraConnectedToast.toggle()
      }

      os_log(
        "Enable Wired USB Control: GoPro %@",
        type: .info,
        self.multiCameraViewModel.cameraConnectionInfoList[index].camera.serialNumber
      )
      self.multiCameraViewModel.cameraConnectionInfoList[index].camera
        .requestUsbCommand(command: .enableWiredUsbControl) { error in
          if error != nil {
            os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
            return
          }
        }
    }
  }

  private func getCreationTimestamp(completion: @escaping (Int) -> Void) {
    var creationTimestamp = 2_147_483_647
    for cameraConnectionInfo in self.multiCameraViewModel.getConnectedCameraList() {
      cameraConnectionInfo.camera.requestUsbMediaList { _, latestCreationTimestamp, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        creationTimestamp = min(creationTimestamp, latestCreationTimestamp)

        if cameraConnectionInfo == self.multiCameraViewModel.cameraConnectionInfoList.last {
          completion(creationTimestamp)
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
