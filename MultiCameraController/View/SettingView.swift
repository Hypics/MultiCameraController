//
//  SettingView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/20/23.
//

import AlertToast
import SwiftUI

struct SettingView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel

  var body: some View {
    VStack {
      Divider()
        .padding([.top, .bottom], 5)
      PresetView(multiCameraViewModel: self.multiCameraViewModel)
      Divider()
        .padding([.top, .bottom], 5)
      Text("Configure List").padding()
      List {
        Button(action: self.multiCameraViewModel.setVideoResolution4K, label: {
          HStack {
            Spacer()
            Image(systemName: "camera")
              .foregroundColor(.pink)
            Text("Video Resolution: 4K")
              .foregroundColor(.pink)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setVideoFps120Hz, label: {
          HStack {
            Spacer()
            Image(systemName: "rectangle.on.rectangle")
              .foregroundColor(.pink)
            Text("Video FPS: 120Hz")
              .foregroundColor(.pink)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setVideoDigitalLensLinear, label: {
          HStack {
            Spacer()
            Image(systemName: "field.of.view.wide")
              .foregroundColor(.red)
            Text("Video Digital Lens: Linear")
              .foregroundColor(.red)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setAntiFlicker60Hz, label: {
          HStack {
            Spacer()
            Image(systemName: "warninglight")
              .foregroundColor(.red)
            Text("Anti Flicker: 60Hz")
              .foregroundColor(.red)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setHyperSmoothOff, label: {
          HStack {
            Spacer()
            Image(systemName: "circle.and.line.horizontal")
              .foregroundColor(.orange)
            Text("Hypersmooth: Off")
              .foregroundColor(.orange)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setHindsightOff, label: {
          HStack {
            Spacer()
            Image(systemName: "arrowshape.turn.up.backward.badge.clock")
              .foregroundColor(.orange)
            Text("Hindsight: Off")
              .foregroundColor(.orange)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setVideoBitRateHigh, label: {
          HStack {
            Spacer()
            Image(systemName: "slider.horizontal.3")
              .foregroundColor(.teal)
            Text("System Video Bit Rate: High")
              .foregroundColor(.teal)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setVideoBitDepth10bit, label: {
          HStack {
            Spacer()
            Image(systemName: "slider.vertical.3")
              .foregroundColor(.teal)
            Text("System Video Bit Depth: 10bit")
              .foregroundColor(.teal)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setAutoPowerDownNever, label: {
          HStack {
            Spacer()
            Image(systemName: "powersleep")
              .foregroundColor(.indigo)
            Text("Auto Power Down: Never")
              .foregroundColor(.indigo)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
        Button(action: self.multiCameraViewModel.setControlsModePro, label: {
          HStack {
            Spacer()
            Image(systemName: "wrench.and.screwdriver")
              .foregroundColor(.indigo)
            Text("Controls Mode: Pro")
              .foregroundColor(.indigo)
            Spacer()
          }
        })
        .listRowSeparator(.hidden)
      }
    }
    .toolbar {
      ToolbarItem(placement: .principal) {
        Text("Settings Control").fontWeight(.bold)
      }
    }
    .toast(isPresenting: self.$multiCameraViewModel.showPreset1Toast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("1.square", .pink),
        title: "Preset 1 :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .primary)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showVideoResolutionToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .pink),
        title: "4K :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showVideoFpsToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("rectangle.on.rectangle", .pink),
        title: "120Hz :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showVideoDigitalLensToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("field.of.view.wide", .red),
        title: "Linear :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showAntiFlickerToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("warninglight", .red),
        title: "60Hz :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showHypersmoothToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("circle.and.line.horizontal", .orange),
        title: "Off :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showHindsightToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("arrowshape.turn.up.backward.badge.clock", .orange),
        title: "Off :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showSystemVideoBitRateToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.horizontal.3", .teal),
        title: "High :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showSystemVideoBitDepthToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.vertical.3", .teal),
        title: "10bit :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showAutoPowerDownToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("powersleep", .indigo),
        title: "Never :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .indigo)
      )
    }
    .toast(isPresenting: self.$multiCameraViewModel.showControlsModeToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("wrench.and.screwdriver", .indigo),
        title: "Pro :\n\(CameraManager.instance.getConnectedCameraCount()) cams",
        style: .style(titleColor: .indigo)
      )
    }
  }
}

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView(multiCameraViewModel: MultiCameraViewModel())
  }
}
