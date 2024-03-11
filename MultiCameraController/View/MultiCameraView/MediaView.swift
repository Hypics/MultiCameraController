//
//  MediaView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct MediaView: View {
  @ObservedObject var mediaViewModel: MediaViewModel
  @Binding var selectedCameraList: [any Camera]

  var body: some View {
    List {
      ForEach(self.selectedCameraList, id: \.serialNumber) { camera in
        Section(header: HStack {
          Image(systemName: "camera")
          Text(camera.cameraName)
        }) {
          ForEach(camera.mediaEndPointList, id: \.self) { mediaEndPoint in
            Button(action: {
              self.mediaViewModel.downloadMedia(mediaEndPoint: mediaEndPoint)
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
                self.mediaViewModel.downloadMedia(mediaEndPoint: mediaEndPoint)
              }, label: {
                Text("Download")
                  .padding([.top, .bottom], 5)
                  .padding([.leading, .trailing], 10)
              })
              .tint(.green)
            }
          }
          .onDelete(perform: self.mediaViewModel.camera.removeMedia)
          .listRowSeparator(.hidden)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)
    }
    .frame(maxHeight: .infinity)
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .onAppear {
      CameraManager.instance.updateMediaEndPointListOfAllCamera(self.selectedCameraList)
    }
    .refreshable(
      action: {
        self.mediaViewModel.camera.updateMediaEndPointList(nil)
      }
    )
  }
}
