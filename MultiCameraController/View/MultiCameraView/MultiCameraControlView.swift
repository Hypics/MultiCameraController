//
//  MultiCameraControlView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct MultiCameraControlView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel

  var body: some View {
    HStack {
      Spacer()
      Spacer()
      Button(action: self.multiCameraViewModel.startShootingAll, label: {
        VStack {
          HStack {
            Image(systemName: "video")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.teal)
          .padding([.top, .bottom], 2)
          Text("Shutter On")
            .foregroundColor(.teal)
        }
      })
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 5)
      .padding([.leading, .trailing], 3)
      Spacer()
      Button(action: self.multiCameraViewModel.stopShootingAll, label: {
        VStack {
          HStack {
            Image(systemName: "stop")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.pink)
          .padding([.top, .bottom], 2)
          Text("Shutter Off")
            .foregroundColor(.pink)
        }
      })
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 5)
      .padding([.leading, .trailing], 3)
      Spacer()
      Button(action: self.multiCameraViewModel.downloadMediaAll, label: {
        VStack {
          HStack {
            Image(systemName: "photo.on.rectangle.angled")
            Image(systemName: "a.circle")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.green)
          .padding([.top, .bottom], 2)
          Text("Download Media")
            .foregroundColor(.green)
        }
      })
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 5)
      .padding([.leading, .trailing], 3)
      Spacer()
      Button(action: self.multiCameraViewModel.removeMediaAll, label: {
        VStack {
          HStack {
            Image(systemName: "trash")
            Image(systemName: "a.circle")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.red)
          .padding([.top, .bottom], 2)
          Text("Remove Media")
            .foregroundColor(.red)
        }
      })
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 5)
      .padding([.leading, .trailing], 3)
      Spacer()
      Button(action: {
        self.multiCameraViewModel.showSettingView = true
      }, label: {
        VStack {
          HStack {
            Image(systemName: "gear")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.orange)
          .padding([.top, .bottom], 2)
          Text("Settings")
            .foregroundColor(.orange)
        }
      })
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding([.top, .bottom], 5)
      .padding([.leading, .trailing], 3)
      Spacer()
      Spacer()
    }
  }
}
