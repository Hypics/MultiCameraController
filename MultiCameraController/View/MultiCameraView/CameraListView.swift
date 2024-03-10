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
  @Binding var viewInfoList: [ViewInfo]
  @Binding var selectedCamera: (any Camera)?

  @State private var isPopoverPresented = false
  @State private var newSerialNumber: String = ""

  var body: some View {
    List {
      Section(header: Text("Camera List")) {
        ForEach(CameraManager.instance.cameraContainer, id: \.self.serialNumber) { camera in
          Button(action: {
            if camera.serialNumber == self.selectedCamera?.serialNumber {
              if camera.isConnected {
                os_log("CameraView: %@", type: .info, camera.cameraName)
                self.viewInfoList.append(.init(view: .cameraView, data: camera))
              } else {
                os_log("CameraView is not connected: %@", type: .error, camera.cameraName)
                self.multiCameraViewModel.showCameraEmptyToast.toggle()
              }
            } else {
              self.selectedCamera = camera
            }
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "camera")
                .foregroundColor(camera.isConnected ? .teal : .pink)
              Text("GoPro " + camera.serialNumber)
                .foregroundColor(camera.isConnected ? .teal : .pink)
              Spacer()
              if camera.serialNumber == self.selectedCamera?.serialNumber {
                Image(systemName: "checkmark.circle")
                  .foregroundColor(camera.isConnected ? .teal : .pink)
              }
            }
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
          .swipeActions(edge: .leading) {
            Button(action: {
              os_log("Connect: %@", type: .info, camera.cameraName)
              camera.checkConnection(nil)
              camera.enableWiredUsbControl(nil)
              self.multiCameraViewModel.showCameraConnectedToast.toggle()
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
        .listRowSeparator(.hidden)
        HStack {
          Spacer()
          Image(systemName: "plus.app")
            .foregroundColor(Color.skyishMyish)
          Text("Add GoPro")
            .foregroundColor(Color.skyishMyish)
          Spacer()
        }
        .frame(height: UIScreen.screenHeight * 0.04)
        .listRowBackground(Color.black)
        .onTapGesture {
          self.isPopoverPresented = true
        }
        .popover(isPresented: self.$isPopoverPresented, content: {
          VStack {
            Text("Enter a serial number")
              .font(.headline)
              .padding()
            TextField("Serial Number (last 3 digits)", text: self.$newSerialNumber)
              .padding()
            Button("Done") {
              self.isPopoverPresented = false
              CameraManager.instance.addCamera(serialNumber: self.newSerialNumber)
              self.newSerialNumber = ""
              UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
            }
            .padding()
          }
          .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenHeight * 0.15)
          .padding()
        })
      }
    }
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .refreshable {
      CameraManager.instance.checkCameraAll()
      CameraManager.instance.enableWiredUsbControlAll()
      self.multiCameraViewModel.showRefreshCameraListToast.toggle()
    }
//    .onChange(of: CameraManager.instance.cameraSerialNumberList) {
//      UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
//    }
  }

  private func moveCameraItem(from source: IndexSet, to destination: Int) {
    os_log("Move GoPro %@", type: .info, CameraManager.instance.cameraContainer[source[source.startIndex]].serialNumber)
    CameraManager.instance.moveCamera(from: source, to: destination)
    UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
  }
}

struct CameraListView_Previews: PreviewProvider {
  @State static var viewInfoList: [ViewInfo] = []
  @State static var selectedCamera: (any Camera)?
  static var previews: some View {
    CameraListView(
      multiCameraViewModel: MultiCameraViewModel(),
      viewInfoList: $viewInfoList,
      selectedCamera: $selectedCamera
    )
  }
}
