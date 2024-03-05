//
//  DownloadMediaView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct DownloadMediaView: View {
  @ObservedObject var cameraViewModel: CameraViewModel

  var body: some View {
    Text("Media List").padding()
    List {
      ForEach(self.cameraViewModel.mediaEndPointList, id: \.self) { mediaEndPoint in
        Button(action: {
          self.cameraViewModel.downloadMedia(mediaEndPoint: mediaEndPoint)
        }, label: {
          HStack {
            Spacer()
            Image(systemName: "photo")
              .foregroundColor(.teal)
            Text(mediaEndPoint)
              .foregroundColor(.teal)
            Spacer()
          }
        })
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
          Button(action: {
            self.cameraViewModel.downloadMedia(mediaEndPoint: mediaEndPoint)
          }, label: {
            Text("Download")
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          })
          .tint(.green)
        }
      }
      .onDelete(perform: self.cameraViewModel.deleteMediaItem)
      .listRowSeparator(.hidden)
    }
    .refreshable(
      action: {
        self.cameraViewModel.downloadMediaList()
      }
    )
  }
}
