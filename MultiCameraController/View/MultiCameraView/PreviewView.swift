//
//  PreviewView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/10/24.
//

import SwiftUI

struct PreviewView: View {
  @ObservedObject var multiCameraViewModel: MultiCameraViewModel
  @Binding var selectedCamera: (any Camera)?

  @State private var isShowPreview = false

  var body: some View {
    List {
      Section(header: HStack {
        Image(systemName: "camera")
        Text(self.selectedCamera?.cameraName ?? "Camera")
        Spacer()
        Button(action: {
          self.isShowPreview.toggle()
        }, label: {
          Image(systemName: self.isShowPreview ? "eye.fill" : "eye")
        })
      }) {
        HStack {
          Spacer()
          Text(self.isShowPreview ? "Preview On" : "Preview Off")
          Spacer()
        }
        .frame(height: UIScreen.screenHeight * 0.6)
        .listRowBackground(Color.black)
      }
      .headerProminence(.increased)
    }
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .scrollDisabled(true)
  }
}

struct PreviewView_Previews: PreviewProvider {
  @State static var selectedCamera: (any Camera)?
  static var previews: some View {
    PreviewView(
      multiCameraViewModel: MultiCameraViewModel(),
      selectedCamera: $selectedCamera
    )
  }
}
