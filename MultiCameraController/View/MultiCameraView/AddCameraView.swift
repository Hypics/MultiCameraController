//
//  AddCameraView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct AddCameraView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel

  var body: some View {
    ZStack {
      HStack {
        Text("GoPro List").padding()
      }
      HStack {
        Spacer()
        TextField("Serial Number (last 3 digits)", text: self.$multiCameraViewModel.newCameraSerialNumber)
          .font(.system(size: 13, weight: .bold, design: .rounded))
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 15)
              .stroke(.gray, lineWidth: 1.0)
          )
          .frame(width: 200)
          .fixedSize(horizontal: true, vertical: false)
        Button(action: {
          CameraManager.instance.addCamera(newCameraSerialNumber: self.multiCameraViewModel.newCameraSerialNumber)
        }, label: {
          HStack {
            Image(systemName: "plus.square")
              .foregroundColor(.red)
            Text("Add")
              .foregroundColor(.red)
          }
        })
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding([.leading], 10)
        .padding([.trailing], 15)
      }
    }
  }
}
