/* CameraSelectionView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraSelectionView.swift
//  MultiCameraController
//

import AlertToast
import Foundation
import os.log
import SwiftUI
import SynologyKit

struct MultiCameraView: View {
  @State private var showServerView = false
  @State private var showSettingsView = false
  @State private var showCameraView = false

  @State private var client = SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true)
  @State private var goProSerialNumberList =
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  @State private var cameraConnectionInfoList: [CameraConnectionInfo] =
    (
      UserDefaults.standard
        .array(forKey: "GoProSerialNumberList") as? [String] ?? []
    )
    .reduce([CameraConnectionInfo]()) { result, item in
      var temp = result
      temp.append(CameraConnectionInfo(camera: GoPro(serialNumber: item)))
      return temp
    }

  @State private var userId: String = UserDefaults.standard
    .string(forKey: "UserId") ?? ""
  @State private var userPassword: String = ""
  @State private var isCameraConnectionInfoListEditable = false
  @State private var targetCameraConnectionInfo = CameraConnectionInfo(camera: GoPro(serialNumber: ""))
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
    NavigationStack {
      VStack {
        Divider()
          .padding([.top, .bottom], 5)
        HStack {
          Spacer()
          Spacer()
          Text("Synology NAS")
            .padding(5)
          TextField("ID", text: self.$userId)
            .padding(10)
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .frame(width: 140)
            .fixedSize(horizontal: true, vertical: false)
            .padding(5)
          SecureField("Password", text: self.$userPassword)
            .padding(10)
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .frame(width: 140)
            .fixedSize(horizontal: true, vertical: false)
            .padding(5)
          Spacer()
          Button(action: {
            if !self.userId.isEmpty {
              os_log("login", type: .info)
              UserDefaults.standard.set(self.userId, forKey: "UserId")
              self.client.login(account: self.userId, passwd: self.userPassword) { response in
                switch response {
                case let .success(authRes):
                  self.client.updateSessionID(authRes.sid)
                  os_log("Synology SID: %@", type: .error, authRes.sid)
                  self.showServerView = true
                case let .failure(error):
                  os_log("Error: %@", type: .error, error.description)
                }
              }
            } else {
              os_log("%@ is empty", type: .error, self.userId)
            }
          }, label: {
            HStack {
              Image(systemName: "network")
                .foregroundColor(.teal)
              Text("Login")
                .foregroundColor(.teal)
            }
          })
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .padding(5)
          Spacer()
          Spacer()
        }
        Divider()
          .padding([.top, .bottom], 5)
        HStack {
          Spacer()
          Spacer()
          Button(action: {
            os_log("Shutter On All", type: .info)
            for cameraConnectionInfo in self.cameraConnectionInfoList.filter({ $0.isConnected == true }) {
              cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOn) { error in
                if error != nil {
                  os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                  return
                }
              }
            }
            self.showSutterOnToast.toggle()
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
            for cameraConnectionInfo in self.cameraConnectionInfoList.filter({ $0.isConnected == true }) {
              cameraConnectionInfo.camera.requestUsbCommand(command: .shutterOff) { error in
                if error != nil {
                  os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                  return
                }
              }
            }
            self.showSutterOffToast.toggle()
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
            for cameraConnectionInfo in self.cameraConnectionInfoList.filter({ $0.isConnected == true }) {
              os_log(
                "Download media list: GoPro %@",
                type: .info,
                cameraConnectionInfo.camera.serialNumber
              )
              cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, error in
                if error != nil {
                  os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                  return
                }

                for mediaEndPoint in mediaEndPointList ?? [] {
                  self.showDownloadMediaToast = true
                  cameraConnectionInfo.camera
                    .requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                      if error != nil {
                        os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                        return
                      }
                      if let progress {
                        if progress > 99.9 {
                          self.showDownloadMediaToast = false
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
            for cameraConnectionInfo in self.cameraConnectionInfoList.filter({ $0.isConnected == true }) {
              os_log("Remove media list: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
              cameraConnectionInfo.camera.requestUsbMediaList { mediaEndPointList, error in
                if error != nil {
                  os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                  return
                }

                for mediaUrl in mediaEndPointList ?? [] {
                  cameraConnectionInfo.camera
                    .requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
                      if error != nil {
                        os_log("Error: %@", type: .error, error as? CVarArg ?? "")
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
            os_log("SettingsView", type: .info)
            self.showSettingsView = true
          }, label: {
            VStack {
              HStack {
                Image(systemName: "gear")
                Image(systemName: "a.circle")
              }
              .foregroundColor(.orange)
              .padding([.top, .bottom], 2)
              Text("Settings")
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
                 !self.cameraConnectionInfoList.contains(where: { $0.camera.serialNumber == newCameraSerialNumber })
              {
                os_log("Add GoPro %@", type: .info, self.newCameraSerialNumber)
                self.goProSerialNumberList.append(self.newCameraSerialNumber)
                self.cameraConnectionInfoList
                  .append(CameraConnectionInfo(camera: GoPro(serialNumber: self.newCameraSerialNumber)))

                let index = self.cameraConnectionInfoList.count - 1
                os_log(
                  "Enable Wired USB Control: GoPro %@",
                  type: .info,
                  self.cameraConnectionInfoList[index].camera.serialNumber
                )
                self.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
                  if error != nil {
                    os_log("Error: %@", type: .error, error as? CVarArg ?? "")
                    if index >= self.cameraConnectionInfoList.count {
                      return
                    }
                    self.cameraConnectionInfoList[index].isConnected = false
                    return
                  }

                  if index >= self.cameraConnectionInfoList.count {
                    return
                  }
                  self.cameraConnectionInfoList[index].isConnected = true
                  self.cameraConnectionInfoList[index].camera
                    .requestUsbCommand(command: .enableWiredUsbControl) { error in
                      if error != nil {
                        os_log("Error: %@", type: .error, error as? CVarArg ?? "")
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
        Divider()
          .padding([.top, .bottom], 5)
        List {
          ForEach(self.cameraConnectionInfoList, id: \.self) { cameraConnectionInfo in
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
                if let index = cameraConnectionInfoList.firstIndex(of: cameraConnectionInfo) {
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
              self.isCameraConnectionInfoListEditable = true
            }
          }
          .listRowSeparator(.hidden)
        }
        .environment(
          \.editMode,
          self.isCameraConnectionInfoListEditable ? .constant(.active) : .constant(.inactive)
        )
        .refreshable {
          for idx in 0 ..< self.cameraConnectionInfoList.count {
            self.connectCameraItem(index: idx)
          }
          self.showRefreshCameraListToast.toggle()
        }
      }
      .onAppear {
        for idx in 0 ..< self.cameraConnectionInfoList.count {
          self.connectCameraItem(index: idx)
        }
        self.showCameraToast.toggle()
      }
      .navigationDestination(isPresented: self.$showServerView) {
        ServerView(client: self.client)
      }
      .navigationDestination(isPresented: self.$showSettingsView) {
        SettingsView(
          cameraConnectionInfoList: self.cameraConnectionInfoList
            .filter { $0.isConnected == true }
        )
      }
      .navigationDestination(isPresented: self.$showCameraView) {
        CameraView(camera: self.targetCameraConnectionInfo.camera)
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
          title: "Connected : \(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
          style: .style(titleColor: .primary)
        )
      }
      .toast(isPresenting: self.$showSutterOnToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("video", .teal),
          title: "Shutter On All : \(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
          style: .style(titleColor: .teal)
        )
      }
      .toast(isPresenting: self.$showSutterOffToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("stop", .pink),
          title: "Shutter Off All : \(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
          style: .style(titleColor: .pink)
        )
      }
      .toast(isPresenting: self.$showDownloadMediaToast) {
        AlertToast(
          type: .loading,
          title: self.downloadMediaUrl,
          subTitle: String(describing: self.downloadProgress) + " %"
        )
      }
      .toast(isPresenting: self.$showRemoveMediaToast, duration: 2, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("trash", .red),
          title: "Remove Media All : \(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
          style: .style(titleColor: .red)
        )
      }
      .toast(isPresenting: self.$showRefreshCameraListToast, duration: 1, tapToDismiss: true) {
        AlertToast(
          displayMode: .alert,
          type: .systemImage("camera", .teal),
          title: "Refresh Camera List : \(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
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
      .onChange(of: self.goProSerialNumberList) {
        UserDefaults.standard.set(self.goProSerialNumberList, forKey: "GoProSerialNumberList")
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }

  private func deleteCameraItem(at offsets: IndexSet) {
    os_log(
      "Remove GoPro %@",
      type: .info,
      self.cameraConnectionInfoList[offsets[offsets.startIndex]].camera.serialNumber
    )
    self.goProSerialNumberList.remove(atOffsets: offsets)
    self.cameraConnectionInfoList.remove(atOffsets: offsets)
  }

  private func moveCameraItem(from source: IndexSet, to destination: Int) {
    os_log("Move GoPro %@", type: .info, self.cameraConnectionInfoList[source[source.startIndex]].camera.serialNumber)
    self.goProSerialNumberList.move(fromOffsets: source, toOffset: destination)
    self.cameraConnectionInfoList.move(fromOffsets: source, toOffset: destination)
    withAnimation {
      self.isCameraConnectionInfoListEditable = false
    }
  }

  private func connectCameraItem(index: Int, showToast: Bool = false) {
    os_log("Connect GoPro %@", type: .info, self.cameraConnectionInfoList[index].camera.serialNumber)
    self.cameraConnectionInfoList[index].camera.requestUsbCameraInfo { _, error in
      if error != nil {
        os_log("Error: %@", type: .error, error as? CVarArg ?? "")
        self.cameraConnectionInfoList[index].isConnected = false
        if showToast {
          self.showCameraEmptyToast.toggle()
        }
        return
      }
      self.cameraConnectionInfoList[index].isConnected = true
      if showToast {
        self.showCameraConnectedToast.toggle()
      }

      os_log(
        "Enable Wired USB Control: GoPro %@",
        type: .info,
        self.cameraConnectionInfoList[index].camera.serialNumber
      )
      self.cameraConnectionInfoList[index].camera.requestUsbCommand(command: .enableWiredUsbControl) { error in
        if error != nil {
          os_log("Error: %@", type: .error, error as? CVarArg ?? "")
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
