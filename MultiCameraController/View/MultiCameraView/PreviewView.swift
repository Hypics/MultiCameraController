//
//  PreviewView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/10/24.
//

import AVKit
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
          if self.isShowPreview {
            self.selectedCamera?.startPreview(nil)
          } else {
            self.selectedCamera?.stopPreview(nil)
          }
        }, label: {
          Image(systemName: self.isShowPreview ? "eye.fill" : "eye")
        })
      }) {
//        HStack {
//          Spacer()
//          Text(self.isShowPreview ? "Preview On" : "Preview Off")
        CustomPlayerView(baseUrl: self.selectedCamera?.baseUrl ?? "")
//            .edgesIgnoringSafeArea(.all)
//          Spacer()
//        }
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

struct CustomPlayerView: UIViewRepresentable {
  var baseUrl: String

  func makeUIView(context _: Context) -> UIView {
    let view = UIView(frame: .zero)
    print(self.baseUrl)
    if let streamUrl = URL(string: "udp://172.27.119.51:8554") {
      let player = AVPlayer(url: streamUrl)
      let playerLayer = AVPlayerLayer(player: player)
      view.layer.addSublayer(playerLayer)
      player.play()
    }
    return view
  }

  func updateUIView(_: UIView, context _: Context) {}
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
