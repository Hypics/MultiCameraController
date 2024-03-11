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
  @Binding var selectedCameraList: [any Camera]
  @Binding var selectedCamera: (any Camera)?

  @State private var isNewCameraPopover = false
  @State private var newSerialNumber: String = ""
  @State private var isCheckAll = false

  var body: some View {
    List {
      Section(header: HStack {
        Image(systemName: "camera.on.rectangle")
        Text("Camera List")
        Spacer()
        Button(action: {
          var tempSelectedCamera = self.selectedCamera
          self.selectedCameraList.removeAll()
          self.selectedCamera = nil

          if !self.isCheckAll {
            for camera in CameraManager.instance.cameraContainer {
              self.selectedCameraList.append(camera)
            }

            if let tempSelectedCamera {
              self.selectedCamera = tempSelectedCamera
            } else {
              self.selectedCamera = self.selectedCameraList.first
            }
          }

          self.isCheckAll.toggle()
        }, label: {
          Image(systemName: self.isCheckAll ? "checkmark.circle.fill" : "checkmark.circle")
        })
      }) {
        ForEach(CameraManager.instance.cameraContainer, id: \.self.serialNumber) { camera in
          Button(action: {
            if (self.selectedCameraList.filter { $0.serialNumber == camera.serialNumber }).count == 1 {
              if let cameraIndex = selectedCameraList.firstIndex(where: { $0.serialNumber == camera.serialNumber }) {
                self.selectedCameraList.remove(at: cameraIndex)

                if camera.serialNumber == self.selectedCamera?.serialNumber {
                  self.selectedCamera = self.selectedCameraList.last
                }

                if self.selectedCameraList.isEmpty {
                  self.selectedCamera = nil
                }
              }
            } else {
              self.selectedCameraList.append(camera)
              self.selectedCamera = camera
            }
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "camera")
                .foregroundColor(camera.isConnected ? .teal : .pink)
              Text(camera.cameraName)
                .foregroundColor(camera.isConnected ? .teal : .pink)
              Spacer()
              if (self.selectedCameraList.filter { $0.serialNumber == camera.serialNumber }).count == 1 {
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
          self.isNewCameraPopover = true
        }
        .popover(isPresented: self.$isNewCameraPopover, content: {
          VStack {
            Text("Enter a serial number")
              .font(.headline)
              .padding()
            TextField("Serial Number (last 3 digits)", text: self.$newSerialNumber)
              .padding()
            Button("Done") {
              self.isNewCameraPopover = false
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
      .headerProminence(.increased)
    }
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .refreshable {
      CameraManager.instance.checkCameraAll(nil)
      CameraManager.instance.enableWiredUsbControlAll(nil)
      self.multiCameraViewModel.showRefreshCameraListToast.toggle()
    }
  }

  private func moveCameraItem(from source: IndexSet, to destination: Int) {
    os_log("Move GoPro %@", type: .info, CameraManager.instance.cameraContainer[source[source.startIndex]].serialNumber)
    CameraManager.instance.moveCamera(from: source, to: destination)
    UserDefaults.standard.set(CameraManager.instance.cameraSerialNumberList, forKey: "GoProSerialNumberList")
  }
}

struct CameraListView_Previews: PreviewProvider {
  @State static var selectedCameraList: [any Camera] = []
  @State static var selectedCamera: (any Camera)?
  static var previews: some View {
    CameraListView(
      multiCameraViewModel: MultiCameraViewModel(),
      selectedCameraList: $selectedCameraList,
      selectedCamera: $selectedCamera
    )
  }
}
