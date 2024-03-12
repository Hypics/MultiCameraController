//
//  MediaView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import AlertToast
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
              self.mediaViewModel.downloadMedia(camera: camera, mediaEndPoint: mediaEndPoint)
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
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
              Button(action: {
                self.mediaViewModel.downloadMedia(camera: camera, mediaEndPoint: mediaEndPoint)
              }, label: {
                Text("Download")
                  .padding([.top, .bottom], 5)
                  .padding([.leading, .trailing], 10)
              })
              .tint(.green)
            }
          }
          .onDelete(
            perform: { indexSet in
              self.mediaViewModel.removeMedia(camera: camera, at: indexSet)
//              camera.updateMediaEndPointList(nil)

              // TODO: with Task (run after done)
//              self.selectedCameraList.refreshView()
            }
          )
          .listRowSeparator(.hidden)
        }
        .listRowSeparator(.hidden)
      }
      .headerProminence(.increased)
    }
    .frame(maxHeight: .infinity)
    .scrollContentBackground(.hidden)
    .background(Color.hauntedMeadow)
    .refreshable(
      action: {
        CameraManager.instance.updateMediaEndPointListOfAllCamera(self.selectedCameraList)
        self.mediaViewModel.showRefreshMediaListToast.toggle()
      }
    )
    .toast(isPresenting: self.$mediaViewModel.showDownloadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.mediaViewModel.downloadMediaEndPoint,
        subTitle: String(format: "%.2f", self.mediaViewModel.downloadProgress) + " %"
      )
    }
    .toast(isPresenting: self.$mediaViewModel.showRemoveMediaToast, duration: 2, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("trash", .red),
        title: "Remove Media All : \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .red)
      )
    }
    .toast(isPresenting: self.$mediaViewModel.showRefreshMediaListToast, duration: 1, tapToDismiss: true) {
      AlertToast(
        displayMode: .alert,
        type: .systemImage("photo", .teal),
        title: "Refreshed : \(self.selectedCameraList.filter { $0.isConnected == true }.count) cams",
        style: .style(titleColor: .teal)
      )
    }
  }
}

struct MediaView_Previews: PreviewProvider {
  @State static var selectedCameraList: [any Camera] = []
  static var previews: some View {
    MediaView(
      mediaViewModel: MediaViewModel(),
      selectedCameraList: $selectedCameraList
    )
  }
}
