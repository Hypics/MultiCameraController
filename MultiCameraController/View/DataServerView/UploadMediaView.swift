//
//  UploadMediaView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI
import SynologyKit

struct UploadMediaView: View {
  @ObservedObject var serverViewModel: ServerViewModel

  var body: some View {
    Text("Folder List").padding()
    List(self.serverViewModel.appFileUrlList ?? [], id: \.self, children: \.childrenItem) { item in
      HStack {
        Image(systemName: item.icon)
          .foregroundColor((item.url.isDirectory) ? Color.teal : .gray)
        Text(item.url.lastPathComponent)
          .foregroundColor((item.url.isDirectory) ? Color.teal : .gray)
      }
      .swipeActions(edge: .leading, allowsFullSwipe: true) {
        Button(action: {
          self.serverViewModel.uploadFolder(uploadItem: item)
        }, label: {
          Text("Upload")
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
        })
        .disabled(item.childrenItem == nil)
        .tint(.green)
      }
      .swipeActions(edge: .trailing, allowsFullSwipe: true) {
        Button(action: {
          self.serverViewModel.deleteFolder(deleteItem: item)
          self.serverViewModel.updateAppFileUrlList()
        }, label: {
          Text("Delete")
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
        })
        .tint(.red)
      }
      .listRowSeparator(.hidden)
    }
    .refreshable(
      action: {
        self.serverViewModel.updateAppFileUrlList()
      }
    )
  }
}
