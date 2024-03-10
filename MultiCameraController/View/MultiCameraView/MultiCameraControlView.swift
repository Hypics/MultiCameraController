//
//  MultiCameraControlView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct MultiCameraControlView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel
  @Binding var viewInfoList: [ViewInfo]

  var body: some View {
    HStack {
      Spacer()
      Button(action: {
        CameraManager.instance.startShootAll()
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
        CameraManager.instance.stopShootAll()
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
      Button(action: self.multiCameraViewModel.downloadMediaAll, label: {
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
      Button(action: self.multiCameraViewModel.removeAllMedia, label: {
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
  }
}

struct MultiCameraControlView_Previews: PreviewProvider {
  @State static var viewInfoList: [ViewInfo] = []
  static var previews: some View {
    MultiCameraControlView(multiCameraViewModel: MultiCameraViewModel(), viewInfoList: $viewInfoList)
  }
}
