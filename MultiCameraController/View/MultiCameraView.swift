/* MultiCameraView.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:10 PM */

//
//  MultiCameraView.swift
//  MultiCameraController
//

import AlertToast
import SwiftUI

struct MultiCameraView: View {
  @StateObject var multiCameraViewModel = MultiCameraViewModel()
  @StateObject var settingViewModel = SettingViewModel()
  @StateObject var mediaViewModel = MediaViewModel()

  @State private var selectedCameraList: [any Camera] = []
  @State private var selectedCamera: (any Camera)?
  @State private var panelType: PanelType = .controlPanel

  var body: some View {
    HStack {
      CameraListView(
        multiCameraViewModel: self.multiCameraViewModel,
        selectedCameraList: self.$selectedCameraList,
        selectedCamera: self.$selectedCamera
      )
      .frame(maxWidth: UIScreen.screenWidth * 0.3, maxHeight: UIScreen.screenHeight * 0.9)

      switch self.$panelType.wrappedValue {
      case .controlPanel:
        VStack {
          PreviewView(
            multiCameraViewModel: self.multiCameraViewModel,
            selectedCamera: self.$selectedCamera
          )
          .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.7)

          MultiCameraControlView(
            multiCameraViewModel: self.multiCameraViewModel,
            selectedCameraList: self.$selectedCameraList
          )
          .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.2)
          .background(Color.hauntedMeadow)
        }
        .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.9)

      case .settingPanel:
        VStack {
          PresetView(settingViewModel: self.settingViewModel, selectedCameraList: self.$selectedCameraList)
            .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.2)
            .background(Color.hauntedMeadow)

          SettingView(settingViewModel: self.settingViewModel, selectedCameraList: self.$selectedCameraList)
            .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.7)
        }
        .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.9)

      case .mediaPanel:
        VStack {
          MediaView(
            mediaViewModel: self.mediaViewModel,
            selectedCameraList: self.$selectedCameraList
          )
        }
        .frame(maxWidth: UIScreen.screenWidth * 0.7, maxHeight: UIScreen.screenHeight * 0.9)
      }
    }
    .navigationTitle("Multi Camera \(self.panelType.toTitle())")
    .foregroundStyle(Color.skyishMyish)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      Button(action: {
        if let nextPanelType = PanelType.getNext(after: self.panelType) {
          self.panelType = nextPanelType
        }

        switch self.panelType {
        case .controlPanel:
          break

        case .settingPanel:
          break

        case .mediaPanel:
          CameraManager.instance.updateMediaEndPointListOfAllCamera(self.selectedCameraList)
          self.selectedCameraList.refreshView() // TODO??
        }
      }, label: {
        switch self.panelType {
        case .controlPanel:
          Image(systemName: "gear")

        case .settingPanel:
          Image(systemName: "photo")

        case .mediaPanel:
          Image(systemName: "video")
        }
      })
    }
    .onAppear {
      CameraManager.instance.checkCameraAll(nil)
      CameraManager.instance.enableWiredUsbControlAll(nil)
      CameraManager.instance.updateMediaEndPointListOfAllCamera(nil)
    }
    .toast(isPresenting: self.$multiCameraViewModel.showShutterOnToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("video", .teal),
        title: "Shutter On All : \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showShutterOffToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("stop", .pink),
        title: "Shutter Off All : \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams",
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
        title: "Remove Media All : \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showRefreshCameraListToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .teal),
        title: "Connected : \(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .teal)
      )
    }
  }
}

struct MultiCameraView_Previews: PreviewProvider {
  static var previews: some View {
    MultiCameraView()
  }
}
