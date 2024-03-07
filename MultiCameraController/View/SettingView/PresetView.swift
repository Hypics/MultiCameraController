//
//  PresetView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct PresetView: View {
  @ObservedObject var settingViewModel: SettingViewModel

  var body: some View {
    HStack {
      Spacer()
      Spacer()
      Button(action: {
        self.settingViewModel.setPreset(.mounted_4k_60fps)
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
  }
}
