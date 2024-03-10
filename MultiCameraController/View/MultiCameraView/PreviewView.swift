//
//  PreviewView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/10/24.
//

import SwiftUI

struct PreviewView: View {
  @Binding var selectedCamera: (any Camera)?

  var body: some View {
    VStack {
      Text("Preview")
      Text(self.selectedCamera?.cameraName ?? "")
    }
  }
}

struct PreviewView_Previews: PreviewProvider {
  @State static var selectedCamera: (any Camera)?
  static var previews: some View {
    PreviewView(selectedCamera: $selectedCamera)
  }
}
