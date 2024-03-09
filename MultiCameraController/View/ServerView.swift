//
//  ServerView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 12/17/23.
//

import AlertToast
import SwiftUI
import SynologyKit

struct ServerView: View {
  @ObservedObject var serverViewModel: ServerViewModel

  var body: some View {
    VStack(content: {
      Divider()
        .padding([.top, .bottom], 5)
      SessionStateView(client: self.$serverViewModel.client)
      Divider()
        .padding([.top, .bottom], 5)
      UploadMediaView(serverViewModel: self.serverViewModel)
    })
    .onAppear(perform: self.serverViewModel.updateAppFileUrlList)
    .onDisappear(perform: self.serverViewModel.logoutSession)
    .toast(isPresenting: self.$serverViewModel.showUploadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.serverViewModel.uploadMediaEndPoint,
        subTitle: String(format: "%.2f", self.serverViewModel.uploadProgress) + " %"
      )
    }
  }
}

struct ServerView_Previews: PreviewProvider {
  static var previews: some View {
    ServerView(serverViewModel: ServerViewModel())
  }
}
