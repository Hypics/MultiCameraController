//
//  CameraStateView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct CameraStateView: View {
  @ObservedObject var mediaViewModel: MediaViewModel

  var body: some View {
    HStack {
      Spacer()
      Spacer()
      VStack {
        Text("Model Name")
          .foregroundColor(.orange)
        Divider()
        Text(self.mediaViewModel.camera.getCameraInfo()?.model_name ?? "")
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      VStack {
        Text("Serial Number")
          .foregroundColor(.orange)
        Divider()
        Text(self.mediaViewModel.camera.getCameraInfo()?.serial_number ?? "")
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      VStack {
        Text("AP SSID")
          .foregroundColor(.orange)
        Divider()
        Text(self.mediaViewModel.camera.getCameraInfo()?.ap_ssid ?? "")
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      VStack {
        Text("Firmware Version")
          .foregroundColor(.orange)
        Divider()
        Text(self.mediaViewModel.camera.getCameraInfo()?.firmware_version ?? "")
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      Spacer()
    }
  }
}
