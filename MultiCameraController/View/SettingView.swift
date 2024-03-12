//
//  SettingView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/20/23.
//

import AlertToast
import SwiftUI

struct SettingView: View {
  @ObservedObject var settingViewModel: SettingViewModel
  @Binding var selectedCameraList: [any Camera]

  var body: some View {
    List {
      Section(header: HStack {
        Image(systemName: "square.arrowtriangle.4.outward")
        Text("Video Resolution")
      }) {
        ForEach(CameraVideoResolution.allCases, id: \.self) { videoResolution in
          Button(action: {
            self.settingViewModel.setVideoResolution(videoResolution, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "square.arrowtriangle.4.outward")
              Text("\(videoResolution.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "rectangle.on.rectangle")
        Text("FPS")
      }) {
        ForEach(CameraFps.allCases, id: \.self) { fps in
          Button(action: {
            self.settingViewModel.setFps(fps, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "rectangle.on.rectangle")
              Text("\(fps.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "field.of.view.wide")
        Text("Digital Lens")
      }) {
        ForEach(CameraDigitalLenses.allCases, id: \.self) { digitalLenses in
          Button(action: {
            self.settingViewModel.setVideoDigitalLens(digitalLenses, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "field.of.view.wide")
              Text("\(digitalLenses.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "warninglight")
        Text("Anti Flicker")
      }) {
        ForEach(CameraAntiFlicker.allCases, id: \.self) { antiFlicker in
          Button(action: {
            self.settingViewModel.setAntiFlicker(antiFlicker, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "warninglight")
              Text("\(antiFlicker.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "circle.and.line.horizontal")
        Text("Hypersmooth")
      }) {
        ForEach(CameraHypersmooth.allCases, id: \.self) { hypersmooth in
          Button(action: {
            self.settingViewModel.setHypersmooth(hypersmooth, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "circle.and.line.horizontal")
              Text("\(hypersmooth.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "arrowshape.turn.up.backward.badge.clock")
        Text("Hindsight")
      }) {
        ForEach(CameraHindsight.allCases, id: \.self) { hindsight in
          Button(action: {
            self.settingViewModel.setHindsight(hindsight, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "arrowshape.turn.up.backward.badge.clock")
              Text("\(hindsight.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "slider.horizontal.3")
        Text("Video Bit Rate")
      }) {
        ForEach(CameraVideoBitRate.allCases, id: \.self) { videoBitRate in
          Button(action: {
            self.settingViewModel.setVideoBitRate(videoBitRate, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "slider.horizontal.3")
              Text("\(videoBitRate.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "slider.vertical.3")
        Text("Video Bit Depth")
      }) {
        ForEach(CameraVideoBitDepth.allCases, id: \.self) { videoBitDepth in
          Button(action: {
            self.settingViewModel.setVideoBitDepth(videoBitDepth, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "slider.vertical.3")
              Text("\(videoBitDepth.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "powersleep")
        Text("Auto Power Down")
      }) {
        ForEach(CameraAutoPowerDown.allCases, id: \.self) { autoPowerDown in
          Button(action: {
            self.settingViewModel.setAutoPowerDown(autoPowerDown, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "powersleep")
              Text("\(autoPowerDown.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)

      Section(header: HStack {
        Image(systemName: "pencil.and.list.clipboard")
        Text("Control Mode")
      }) {
        ForEach(CameraControlMode.allCases, id: \.self) { controlMode in
          Button(action: {
            self.settingViewModel.setControlsMode(controlMode, self.selectedCameraList)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "pencil.and.list.clipboard")
              Text("\(controlMode.toString())")
              Spacer()
            }
            .foregroundStyle(.white)
          })
          .frame(height: UIScreen.screenHeight * 0.04)
          .listRowBackground(Color.black)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)
    }
    .frame(maxHeight: .infinity)
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .toast(isPresenting: self.$settingViewModel.showPreset1Toast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("1.square", .pink),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .primary)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showVideoResolutionToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("square.arrowtriangle.4.outward", .pink),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showVideoFpsToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("rectangle.on.rectangle", .pink),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showVideoDigitalLensToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("field.of.view.wide", .red),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showAntiFlickerToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("warninglight", .red),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showHypersmoothToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("circle.and.line.horizontal", .orange),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showHindsightToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("arrowshape.turn.up.backward.badge.clock", .orange),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showSystemVideoBitRateToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.horizontal.3", .teal),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showSystemVideoBitDepthToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.vertical.3", .teal),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showAutoPowerDownToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("powersleep", .indigo),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .indigo)
      )
    }
    .toast(isPresenting: self.$settingViewModel.showControlsModeToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("pencil.and.list.clipboard", .indigo),
        title: """
        \(self.settingViewModel.toastString) :
        \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams
        """,
        style: .style(titleColor: .indigo)
      )
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  @State static var selectedCameraList: [any Camera] = []
  static var previews: some View {
    SettingView(settingViewModel: SettingViewModel(), selectedCameraList: $selectedCameraList)
  }
}
