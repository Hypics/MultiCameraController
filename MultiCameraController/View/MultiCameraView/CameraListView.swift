//
//  CameraListView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import os.log
import SwiftUI

struct CameraListView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel

  var body: some View {
    List {
      ForEach(CameraManager.instance.cameraContainer, id: \.self.serialNumber) { camera in
        Button(action: {
          if camera.isConnected {
            os_log("CameraView: GoPro %@", type: .info, camera.serialNumber)
            self.multiCameraViewModel.targetCamera = camera
            self.multiCameraViewModel.showCameraView = true
          } else {
            os_log(
              "CameraView is not connected: GoPro %@",
              type: .error,
              camera.serialNumber
            )
            self.multiCameraViewModel.showCameraEmptyToast.toggle()
          }
        }, label: {
          HStack {
            Spacer()
            if camera.isConnected {
              Image(systemName: "camera")
                .foregroundColor(.teal)
              Text("GoPro " + camera.serialNumber)
                .foregroundColor(.teal)
              Spacer()
              Image(systemName: "chevron.right")
                .renderingMode(.template)
                .foregroundColor(.teal)
            } else {
              Image(systemName: "camera")
                .foregroundColor(.pink)
              Text("GoPro " + camera.serialNumber)
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
            os_log("Connect: GoPro %@", type: .info, camera.serialNumber)
            self.multiCameraViewModel.connectCameraItem(camera: camera, showToast: true)
          }, label: {
            Text("Connect")
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          })
          .tint(.teal)
        }
      }
      .onDelete(perform: self.multiCameraViewModel.deleteCameraItem)
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
      for camera in CameraManager.instance.cameraContainer {
        self.multiCameraViewModel.connectCameraItem(camera: camera)
      }
      self.multiCameraViewModel.showRefreshCameraListToast.toggle()
    }
  }

  private func moveCameraItem(from source: IndexSet, to destination: Int) {
    os_log(
      "Move GoPro %@",
      type: .info,
      CameraManager.instance.cameraContainer[source[source.startIndex]].serialNumber
    )
    self.multiCameraViewModel.goProSerialNumberList.move(fromOffsets: source, toOffset: destination)
    CameraManager.instance.cameraContainer.move(fromOffsets: source, toOffset: destination)
    withAnimation {
      self.multiCameraViewModel.cameraConnectionInfoListEditable = false
    }
  }
}
