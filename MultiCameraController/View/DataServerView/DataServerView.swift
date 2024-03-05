//
//  DataServerView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 12/17/23.
//

import AlertToast
import SwiftUI
import SynologyKit

struct DataServerView: View {
  @ObservedObject var dataServerViewModel: DataServerViewModel

  var body: some View {
    VStack(content: {
      Divider()
        .padding([.top, .bottom], 5)
      SessionStateView(client: self.$dataServerViewModel.client)
      Divider()
        .padding([.top, .bottom], 5)
      UploadMediaView(dataServerViewModel: self.dataServerViewModel)
    })
    .onAppear(perform: self.dataServerViewModel.getAppFileUrlList)
    .onDisappear(perform: self.dataServerViewModel.logoutSession)
    .toast(isPresenting: self.$dataServerViewModel.showUploadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.dataServerViewModel.uploadMediaUrl,
        subTitle: String(format: "%.2f", self.dataServerViewModel.uploadProgress) + " %"
      )
    }
  }
}

struct ServerView_Previews: PreviewProvider {
  static var previews: some View {
    DataServerView(dataServerViewModel: DataServerViewModel())
  }
}
