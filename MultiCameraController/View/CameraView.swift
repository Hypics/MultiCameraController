/* CameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  CameraView.swift
//  MultiCameraController
//

import AlertToast
import SwiftUI

struct CameraView: View {
  @ObservedObject var cameraViewModel: CameraViewModel

  var body: some View {
    VStack(content: {
      Divider()
        .padding([.top, .bottom], 5)
      CameraStateView(cameraViewModel: self.cameraViewModel)
      Divider()
        .padding([.top, .bottom], 5)
      CameraControlView(cameraViewModel: self.cameraViewModel)
      Divider()
        .padding([.top, .bottom], 5)
      DownloadMediaView(cameraViewModel: self.cameraViewModel)
    })
    .onAppear {
      self.cameraViewModel.camera.checkConnection(nil)
      self.cameraViewModel.camera.updateMediaUrlStringList(nil)
    }
    .toast(isPresenting: self.$cameraViewModel.showShutterOnToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("video", .teal),
        title: "Shutter On : GoPro \(self.cameraViewModel.camera.serialNumber)",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$cameraViewModel.showShutterOffToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("stop", .pink),
        title: "Shutter Off : GoPro \(self.cameraViewModel.camera.serialNumber)",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$cameraViewModel.showDownloadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.cameraViewModel.downloadMediaUrl,
        subTitle: String(format: "%.2f", self.cameraViewModel.downloadProgress) + " %"
      )
    }
    .toast(isPresenting: self.$cameraViewModel.showRemoveMediaToast, duration: 2, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("trash", .red),
        title: "\(self.cameraViewModel.camera.cameraName): \(self.cameraViewModel.getMediaListCount())",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$cameraViewModel.showRefreshMediaListToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("photo", .teal),
        title: "\(self.cameraViewModel.camera.cameraName): \(self.cameraViewModel.getMediaListCount())",
        style: .style(titleColor: .teal)
      )
    }
  }
}

struct CameraView_Previews: PreviewProvider {
  static var previews: some View {
    CameraView(cameraViewModel: CameraViewModel(camera: GoPro(serialNumber: "")))
  }
}
