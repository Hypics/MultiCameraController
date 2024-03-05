//
//  SettingsView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 11/20/23.
//

import AlertToast
import os.log
import SwiftUI

struct SettingsView: View {
  var cameraConnectionInfoList: [CameraConnectionInfo]

  @State private var showPreset1Toast = false
  @State private var showVideoResolutionToast = false
  @State private var showVideoFpsToast = false
  @State private var showVideoDigitalLensToast = false
  @State private var showAntiFlickerToast = false
  @State private var showHypersmoothToast = false
  @State private var showHindsightToast = false
  @State private var showSystemVideoBitRateToast = false
  @State private var showSystemVideoBitDepthToast = false
  @State private var showAutoPowerDownToast = false
  @State private var showControlsModeToast = false
  var body: some View {
    VStack {
      Divider()
        .padding([.top, .bottom], 5)
      HStack {
        Spacer()
        Spacer()
        Button(action: {
          os_log("4K@120FPS, 16:9, Linear, 60Hz, Off, High, 10bit, Never, Pro", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            for presetSetting in GoProUsbSettingPreset.mounted_4k_120fps.settings {
              cameraConnectionInfo.camera.requestUsbSetting(setting: presetSetting) { error in
                if error != nil {
                  os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                  return
                }
              }
            }
          }
          self.showPreset1Toast.toggle()
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
        Spacer()
      }
      Divider()
        .padding([.top, .bottom], 5)
      Text("Configure List").padding()
      List {
        Button(action: {
          os_log("Video Resolution: 4K, 16:9", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .videoResolution_4k_16_9) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showVideoResolutionToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Video FPS: 120Hz", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .fps_120) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showVideoFpsToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Video Digital Lens: Linear", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .videoDigitalLenses_linear) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showVideoDigitalLensToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Anti Flicker: 60Hz", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .antiFlicker_60) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showAntiFlickerToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Hypersmooth: Off", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .hypersmooth_off) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showHypersmoothToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Hindsight: Off", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .hindsight_off) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showHindsightToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("System Video Bit Rate: High", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .systemVideoBitRate_high) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showSystemVideoBitRateToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("System Video Bit Depth: 10bit", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .systemVideoBitDepth_10bit) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showSystemVideoBitDepthToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Auto Power Down: Never", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .autoPowerDown_never) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showAutoPowerDownToast.toggle()
        }, label: {
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
        Button(action: {
          os_log("Controls Mode: Pro", type: .info)
          for cameraConnectionInfo in self.cameraConnectionInfoList {
            cameraConnectionInfo.camera.requestUsbSetting(setting: .controls_pro) { error in
              if error != nil {
                os_log("Error: %@", type: .error, error?.localizedDescription ?? "")
                return
              }
            }
          }
          self.showControlsModeToast.toggle()
        }, label: {
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
    .toast(isPresenting: self.$showPreset1Toast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("1.square", .pink),
        title: "Preset 1 :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .primary)
      )
    }
    .toast(isPresenting: self.$showVideoResolutionToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("camera", .pink),
        title: "4K :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$showVideoFpsToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("rectangle.on.rectangle", .pink),
        title: "120Hz :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .pink)
      )
    }
    .toast(isPresenting: self.$showVideoDigitalLensToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("field.of.view.wide", .red),
        title: "Linear :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$showAntiFlickerToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("warninglight", .red),
        title: "60Hz :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$showHypersmoothToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("circle.and.line.horizontal", .orange),
        title: "Off :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$showHindsightToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("arrowshape.turn.up.backward.badge.clock", .orange),
        title: "Off :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .orange)
      )
    }
    .toast(isPresenting: self.$showSystemVideoBitRateToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.horizontal.3", .teal),
        title: "High :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$showSystemVideoBitDepthToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("slider.vertical.3", .teal),
        title: "10bit :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .teal)
      )
    }
    .toast(isPresenting: self.$showAutoPowerDownToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("powersleep", .indigo),
        title: "Never :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .indigo)
      )
    }
    .toast(isPresenting: self.$showControlsModeToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("wrench.and.screwdriver", .indigo),
        title: "Pro :\n\(self.cameraConnectionInfoList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .indigo)
      )
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(cameraConnectionInfoList: [])
  }
}
