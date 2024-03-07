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
  @StateObject var dataServerViewModel = DataServerViewModel()

  var body: some View {
    NavigationStack {
      VStack {
        Divider()
          .padding([.top, .bottom], 5)
        LoginView(dataServerViewModel: self.dataServerViewModel)
        Divider()
          .padding([.top, .bottom], 5)
        MultiCameraControlView(multiCameraViewModel: self.multiCameraViewModel)
        Divider()
          .padding([.top, .bottom], 5)
        AddCameraView(multiCameraViewModel: self.multiCameraViewModel)
        CameraListView(multiCameraViewModel: self.multiCameraViewModel)
      }
      .onAppear {
        CameraManager.instance.checkCameraAll()
        CameraManager.instance.enableWiredUsbControlAll()
        self.multiCameraViewModel.showCameraToast.toggle()
      }
      .navigationDestination(isPresented: self.$dataServerViewModel.showDataServerView) {
        DataServerView(dataServerViewModel: self.dataServerViewModel)
      }
      .navigationDestination(isPresented: self.$multiCameraViewModel.showSettingView) {
        SettingView(
          multiCameraViewModel: self.multiCameraViewModel
        )
      }
      .navigationDestination(isPresented: self.$multiCameraViewModel.showCameraView) {
        CameraView(cameraViewModel: CameraViewModel(
          camera: self.multiCameraViewModel.targetCamera
        ))
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          Text("Multi Camera Control").fontWeight(.bold)
        }
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
      .onChange(of: CameraManager.instance.cameraSerialNumberList) {
        UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct MultiCameraView_Previews: PreviewProvider {
  static var previews: some View {
    MultiCameraView()
  }
}
