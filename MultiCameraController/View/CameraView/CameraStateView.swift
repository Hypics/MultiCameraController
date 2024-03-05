//
//  CameraStateView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct CameraStateView: View {
  @ObservedObject var cameraViewModel: CameraViewModel

  var body: some View {
    HStack {
      Spacer()
      Spacer()
      VStack {
        Text("Model Name")
          .foregroundColor(.orange)
        Divider()
        Text(self.cameraViewModel.cameraInfo?.model_name ?? "")
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
        Text(self.cameraViewModel.cameraInfo?.serial_number ?? "")
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
        Text(self.cameraViewModel.cameraInfo?.ap_ssid ?? "")
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
        Text(self.cameraViewModel.cameraInfo?.firmware_version ?? "")
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
