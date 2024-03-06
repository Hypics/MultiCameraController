//
//  CameraControlView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct CameraControlView: View {
  @ObservedObject var cameraViewModel: CameraViewModel

  var body: some View {

    HStack {
      Spacer()
      Spacer()
      Button(action: self.cameraViewModel.startShoot, label: {
        VStack {
          Image(systemName: "video")
            .foregroundColor(.teal)
            .padding([.top, .bottom], 2)
          Text("Shutter On")
            .foregroundColor(.teal)
        }
      })
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      Button(action: self.cameraViewModel.stopShoot, label: {
        VStack {
          Image(systemName: "stop")
            .foregroundColor(.pink)
            .padding([.top, .bottom], 2)
          Text("Shutter Off")
            .foregroundColor(.pink)
        }
      })
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      Button(action: self.cameraViewModel.downloadMediaAll, label: {
        VStack {
          HStack {
            Image(systemName: "photo.on.rectangle.angled")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.green)
          .padding([.top, .bottom], 2)
          Text("Download Media")
            .foregroundColor(.green)
        }
      })
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      Button(action: self.cameraViewModel.removeAllMedia, label: {
        VStack {
          HStack {
            Image(systemName: "trash")
            Image(systemName: "a.circle")
          }
          .foregroundColor(.red)
          .padding([.top, .bottom], 2)
          Text("Remove Media")
            .foregroundColor(.red)
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
