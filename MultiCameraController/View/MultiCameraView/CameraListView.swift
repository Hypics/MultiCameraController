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
      ForEach(self.multiCameraViewModel.cameraConnectionInfoList, id: \.self) { cameraConnectionInfo in
        Button(action: {
          if cameraConnectionInfo.isConnected {
            os_log("CameraView: GoPro %@", type: .info, cameraConnectionInfo.camera.serialNumber)
            self.multiCameraViewModel.targetCameraConnectionInfo = cameraConnectionInfo
            self.multiCameraViewModel.showCameraView = true
          } else {
            os_log(
              "CameraView is not connected: GoPro %@",
              type: .error,
              cameraConnectionInfo.camera.serialNumber
            )
            self.multiCameraViewModel.showCameraEmptyToast.toggle()
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
              self.multiCameraViewModel.connectCameraItem(index: index, showToast: true)
            }
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
      for idx in 0 ..< self.multiCameraViewModel.cameraConnectionInfoList.count {
        self.multiCameraViewModel.connectCameraItem(index: idx)
      }
      self.multiCameraViewModel.showRefreshCameraListToast.toggle()
    }
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
}
