/* MultiCameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  MultiCameraView.swift
//  MultiCameraController
//

import AlertToast
import SwiftUI

struct MultiCameraView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel
  @ObservedObject var serverViewModel: ServerViewModel
  @Binding var viewInfoList: [ViewInfo]

  @State private var isSettingView = false
  @State private var selectedCamera: (any Camera)?

  var body: some View {
    HStack {
      CameraListView(
        multiCameraViewModel: self.multiCameraViewModel,
        viewInfoList: self.$viewInfoList,
        selectedCamera: self.$selectedCamera
      )
      .frame(maxWidth: UIScreen.screenWidth * 0.3, maxHeight: UIScreen.screenHeight * 0.9)
      .background(Color.hauntedMeadow)

      if self.isSettingView {
        SettingView(settingViewModel: SettingViewModel())
          .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.9)
      } else {
        VStack {
          PreviewView(selectedCamera: self.$selectedCamera)
            .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.7)
            .background(Color.hauntedMeadow)
          MultiCameraControlView(multiCameraViewModel: self.multiCameraViewModel, viewInfoList: self.$viewInfoList)
            .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.2)
            .background(Color.hauntedMeadow)
        }
        .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.9)
      }
    }
    .navigationTitle("Multi Camera Control")
    .foregroundStyle(Color.skyishMyish)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      Button(action: {
        self.isSettingView.toggle()
      }, label: {
        if self.isSettingView {
          Image(systemName: "video")
        } else {
          Image(systemName: "gear")
        }
      })
    }
    .onAppear {
      CameraManager.instance.checkCameraAll()
      CameraManager.instance.enableWiredUsbControlAll()
      self.multiCameraViewModel.showCameraToast.toggle()
    }
    .toast(isPresenting: self.$multiCameraViewModel.showCameraToast, duration: 3, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .primary),
        title: "Connected : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .primary)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showShutterOnToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("video", .teal),
        title: "Shutter On All : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showShutterOffToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("stop", .pink),
        title: "Shutter Off All : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showDownloadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.multiCameraViewModel.downloadMediaEndPoint,
        subTitle: String(format: "%.2f", self.multiCameraViewModel.downloadProgress) + " %"
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showRemoveMediaToast, duration: 2, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("trash", .red),
        title: "Remove Media All : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showRefreshCameraListToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .teal),
        title: "Refresh Camera List : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showCameraConnectedToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .teal),
        title: "Success : Camera is connected",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showCameraEmptyToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .pink),
        title: "Fail : Camera is not connected",
        style: .style(titleColor: .pink)
      )
    }
  }
}

struct MultiCameraView_Previews: PreviewProvider {
  @State static var viewInfoList: [ViewInfo] = []
  static var previews: some View {
    MultiCameraView(
      multiCameraViewModel: MultiCameraViewModel(),
      serverViewModel: ServerViewModel(),
      viewInfoList: $viewInfoList
    )
  }
}
