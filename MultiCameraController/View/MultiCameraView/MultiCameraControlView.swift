//
//  MultiCameraControlView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct MultiCameraControlView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel
  @Binding var selectedCameraList: [any Camera]

  @State private var isCameraListPopover = false

  var body: some View {
    VStack {
      List {
        Section(header: HStack {
          Image(systemName: "wrench.and.screwdriver")
          Text("Control")
          Spacer()
          Button(action: {
            self.isCameraListPopover = true
          }, label: {
            Image(systemName: "list.bullet")
          })
          .popover(isPresented: self.$isCameraListPopover, content: {
            VStack {
              List {
                Section(header: HStack {
                  Image(systemName: "camera.on.rectangle")
                  Text("Selected Camera")
                }) {
                  ForEach(self.selectedCameraList, id: \.serialNumber) { camera in
                    HStack {
                      Spacer()
                      Image(systemName: "camera")
                      Text(camera.cameraName)
                      Spacer()
                    }
                    .foregroundStyle(.white)
                  }
                  .listRowSeparator(.hidden)
                }
              }
              Button("Done") {
                self.isCameraListPopover = false
              }
            }
            .frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.4)
            .padding()
          })
        }) {
          HStack {
            Spacer()
            Button(action: {
              CameraManager.instance.startShootAll(self.selectedCameraList)
              self.multiCameraViewModel.showShutterOnToast.toggle()
            }, label: {
              VStack {
                HStack {
                  Image(systemName: "video")
                }
                .foregroundColor(.teal)
                .padding([.top, .bottom], 2)
                Text("Shutter On")
                  .foregroundColor(.teal)
              }
            })
            .frame(height: UIScreen.screenHeight * 0.05)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 3)
            Spacer()
            Button(action: {
              CameraManager.instance.stopShootAll(self.selectedCameraList)
              self.multiCameraViewModel.showShutterOffToast.toggle()
            }, label: {
              VStack {
                HStack {
                  Image(systemName: "stop")
                }
                .foregroundColor(.pink)
                .padding([.top, .bottom], 2)
                Text("Shutter Off")
                  .foregroundColor(.pink)
              }
            })
            .frame(height: UIScreen.screenHeight * 0.05)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 3)
            Spacer()
            Button(action: {
              self.multiCameraViewModel.downloadMediaAll(self.selectedCameraList)
            }, label: {
              VStack {
                HStack {
                  Image(systemName: "square.and.arrow.down.on.square")
                }
                .foregroundColor(.green)
                .padding([.top, .bottom], 2)
                Text("Download Media")
                  .foregroundColor(.green)
              }
            })
            .frame(height: UIScreen.screenHeight * 0.05)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 3)
            Spacer()
            Button(action: {
              self.multiCameraViewModel.removeAllMedia(self.selectedCameraList)
            }, label: {
              VStack {
                HStack {
                  Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .padding([.top, .bottom], 2)
                Text("Remove Media")
                  .foregroundColor(.red)
              }
            })
            .frame(height: UIScreen.screenHeight * 0.05)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 3)
            Spacer()
          }
          .listRowBackground(Color.hauntedMeadow)
        }
        .headerProminence(.increased)
      }
      .scrollContentBackground(.hidden)
      .background(Color.hauntedMeadow)
      .scrollDisabled(true)
    }
  }
}

struct MultiCameraControlView_Previews: PreviewProvider {
  @State static var selectedCameraList: [any Camera] = []
  static var previews: some View {
    MultiCameraControlView(multiCameraViewModel: MultiCameraViewModel(), selectedCameraList: $selectedCameraList)
  }
}
