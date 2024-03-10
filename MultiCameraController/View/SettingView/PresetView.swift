//
//  PresetView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct PresetView: View {
  @ObservedObject var settingViewModel: SettingViewModel
  @Binding var selectedCameraList: [any Camera]

  @State private var isCameraListPopover = false

  var body: some View {
    VStack {
      List {
        Section(header: HStack {
          Image(systemName: "number.square")
          Text("Preset")
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
              self.settingViewModel.setPreset(.mounted_4k_60fps, self.selectedCameraList)
            }, label: {
              VStack {
                Image(systemName: "1.square")
                  .foregroundColor(.pink)
                  .padding([.top, .bottom], 5)
                  .padding([.leading, .trailing], 10)
                Text("4K@120FPS, 16:9, Linear")
                  .foregroundColor(.primary)
                Text("60Hz, Off, High, 10bit, Never, Pro")
                  .foregroundColor(.primary)
                  .padding([.top, .bottom], 5)
                  .padding([.leading, .trailing], 10)
              }
            })
            .padding(10)
            .overlay(
              RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 1.0)
            )
            .padding(5)
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

struct PresetView_Previews: PreviewProvider {
  @State static var selectedCameraList: [any Camera] = []
  static var previews: some View {
    PresetView(settingViewModel: SettingViewModel(), selectedCameraList: $selectedCameraList)
  }
}
