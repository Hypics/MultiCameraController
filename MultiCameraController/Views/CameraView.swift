/* CameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraView.swift
//  MultiCameraController
//

import AlertToast
import os.log
import SwiftUI

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
          Text(self.cameraInfo?.model_name ?? "")
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
          Text(self.cameraInfo?.serial_number ?? "")
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
          Text(self.cameraInfo?.ap_ssid ?? "")
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
          Text(self.cameraInfo?.firmware_version ?? "")
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
          self.camera.requestUsbCommand(command: .shutterOn) { error in
            if error != nil {
              os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
              return
            }
          }
          self.showSutterOnToast.toggle()
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
          self.camera.requestUsbCommand(command: .shutterOff) { error in
            if error != nil {
              os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
              return
            }
          }
          self.showSutterOffToast.toggle()
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
          for mediaEndPoint in self.mediaEndPointList {
            self.showDownloadMediaToast = true
            self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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
          for mediaUrl in self.mediaEndPointList {
            self.camera.requestUsbMediaRemove(mediaEndPoint: mediaUrl) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showRemoveMediaToast.toggle()
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
        ForEach(self.mediaEndPointList, id: \.self) { mediaEndPoint in
          Button(action: {
            os_log("Download Media: %@", type: .info, mediaEndPoint)
            self.showDownloadMediaToast = true
            self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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
          }, label: {
            HStack {
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
              self.showDownloadMediaToast = true
              self.camera.requestUsbMediaDownload(mediaEndPoint: mediaEndPoint) { progress, error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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
            }, label: {
              Text("Download")
                .padding([.top, .bottom], 5)
                .padding([.leading, .trailing], 10)
            })
            .tint(.green)
          }
        }
        .onDelete(perform: self.deleteMediaItem)
        .listRowSeparator(.hidden)
      }
      .refreshable {
        os_log("Download media list: GoPro %@", type: .info, self.camera.serialNumber)
        self.camera.requestUsbMediaList { mediaEndPointList, _, error in
          if error != nil {
            os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
            return
          }
          self.mediaEndPointList = mediaEndPointList ?? []
        }
        self.showRefreshMediaListToast.toggle()
      }
    })
    .onAppear {
      os_log("Get camera info: GoPro %@", type: .info, self.camera.serialNumber)
      self.camera.requestUsbCameraInfo { cameraInfo, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        self.cameraInfo = cameraInfo
      }

      os_log("Download media list: GoPro %@", type: .info, self.camera.serialNumber)
      self.camera.requestUsbMediaList { mediaEndPointList, _, error in
        if error != nil {
          os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
          return
        }
        self.mediaEndPointList = mediaEndPointList ?? []
      }
    }
    .toast(isPresenting: self.$showSutterOnToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("video", .teal),
        title: "Shutter On : GoPro \(self.camera.serialNumber)",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$showSutterOffToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("stop", .pink),
        title: "Shutter Off : GoPro \(self.camera.serialNumber)",
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
        title: "GoPro \(self.camera.serialNumber): \(String(describing: self.mediaEndPointList.count)) files",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$showRefreshMediaListToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("photo", .teal),
        title: "GoPro \(self.camera.serialNumber): \(String(describing: self.mediaEndPointList.count)) files",
        style: .style(titleColor: .teal)
      )
    }
  }

  private func deleteMediaItem(at offsets: IndexSet) {
    self.camera.requestUsbMediaRemove(mediaEndPoint: self.mediaEndPointList[offsets[offsets.startIndex]]) { error in
      if error != nil {
        os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
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