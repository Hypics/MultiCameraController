//
//  ServerView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 12/17/23.
//

import AlertToast
import os.log
import SwiftUI
import SynologyKit

struct ServerView: View {
  var client: SynologyClient
  var userId: String
  @State private var appFileUrlList: [FileItem]?
  @State private var uploadMediaUrl: String = ""
  @State private var uploadProgress: Double = 0.0

  @State private var showUploadMediaToast = false

  var body: some View {
    VStack(content: {
      Divider()
        .padding([.top, .bottom], 5)
      HStack {
        Spacer()
        Spacer()
        VStack {
          Text("Session ID")
            .foregroundColor(.orange)
          Divider()
          Text(self.client.sessionid ?? "")
        }
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding(5)
        Spacer()
        VStack {
          Text("Connected")
            .foregroundColor(.orange)
          Divider()
          Text(self.client.connected.description)
        }
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding(5)
        Spacer()
        Spacer()
      }
      Divider()
        .padding([.top, .bottom], 5)
      Text("Folder List").padding()
      List(self.appFileUrlList ?? [], children: \.childrenItem) { item in
        HStack {
          Image(systemName: item.icon)
            .foregroundColor((item.url.isDirectory) ? Color.teal : .gray)
          Text(item.url.lastPathComponent)
            .foregroundColor((item.url.isDirectory) ? Color.teal : .gray)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
          Button(action: {
            os_log("Upload Folder: %@", type: .info, item.url.lastPathComponent)
//            self.showDownloadMediaToast = true
            guard let folderFileChildrenItems: [FileItem] = item.childrenItem else {
              os_log("%@ is not directory", type: .info, item.url.lastPathComponent)
              return
            }
            for childrenItem in folderFileChildrenItems {
              let destinationFolderPath = "/dataset/4DGaussians/" + self.userId + "/" + item.url.lastPathComponent
              os_log("destination folder path: %@", type: .info, destinationFolderPath)

              self.showUploadMediaToast = true
              self.client.upload(
                fileURL: childrenItem.url,
                filename: childrenItem.url.lastPathComponent,
                destinationFolderPath: destinationFolderPath,
                createParents: true,
                options: nil,
                progressHandler: { progress in
//                  if progress.fractionCompleted * 100.0 > 99.9 {
//                    self.showUploadMediaToast = false
//                  }
                  self.uploadMediaUrl = "[" + self.userId + "] " + item.url.lastPathComponent + "/" + childrenItem.url
                    .lastPathComponent
                  self.uploadProgress = progress.fractionCompleted * 100.0
                },
                completion: { result in
                  switch result {
                  case let .success(response):
                    print(response)
                    self.showUploadMediaToast = false
                  case let .failure(error):
                    os_log("Error: %@", type: .error, error.localizedDescription)
                    self.showUploadMediaToast = false
                  }
                }
              )
            }
          }, label: {
            Text("Upload")
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          })
          .disabled(item.childrenItem == nil)
          .tint(.green)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
          Button(action: {
            os_log("Delete Folder or File: %@", type: .info, item.url.lastPathComponent)
            do {
              try FileManager.default.removeItem(at: item.url)
            } catch {
              os_log("Could not remove item: %@", type: .info, error.localizedDescription)
            }

            os_log("Refresh app file list", type: .info)
            self.getAppFileUrlList()
          }, label: {
            Text("Delete")
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          })
          .tint(.red)
        }
        .listRowSeparator(.hidden)
      }
      .refreshable {
        os_log("Refresh app file list", type: .info)
        self.getAppFileUrlList()
//        self.showRefreshMediaListToast.toggle()
      }
    })
    .onAppear(perform: self.getAppFileUrlList)
    .onDisappear {
      // This block is not called when the view goes back.
      self.client.logout { _ in
        os_log("logout: %@", type: .info, self.client.sessionid ?? "")
      }
    }
    .toast(isPresenting: self.$showUploadMediaToast) {
      AlertToast(
        type: .loading,
        title: self.uploadMediaUrl,
        subTitle: String(format: "%.2f", self.uploadProgress) + " %"
      )
    }
  }

  private func getAppFileUrlList() {
    do {
      let documentDirectory = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      os_log("documentDirectory: %@", type: .info, documentDirectory.path)
      self.appFileUrlList = self.getFileItemList(fileUrl: documentDirectory)?
        .filter { $0.url.lastPathComponent != ".Trash" }
    } catch {
      os_log("Error: %@", type: .error, error.localizedDescription)
    }
  }

  private func getFileItemList(fileUrl: URL) -> [FileItem]? {
    if fileUrl.isDirectory {
      var fileContentsUrlList: [URL] = []
      do {
        fileContentsUrlList = try FileManager.default.contentsOfDirectory(
          at: fileUrl,
          includingPropertiesForKeys: nil
        )
      } catch {
        os_log("Error: %@", type: .error, error.localizedDescription)
      }

      if fileContentsUrlList.isEmpty {
        return []
      } else {
        return fileContentsUrlList.reduce([FileItem]()) { result, fileContentsUrl in
          var temp = result
          temp.append(FileItem(url: fileContentsUrl, childrenItem: self.getFileItemList(fileUrl: fileContentsUrl)))
          return temp
        }
        .sorted(by: { first, second -> Bool in
          if first.url.isDirectory == second.url.isDirectory {
            return first.url.lastPathComponent < second.url.lastPathComponent
          } else {
            return first.url.isDirectory
          }
        })
      }
    } else {
      return nil
    }
  }
}

struct ServerView_Previews: PreviewProvider {
  static var previews: some View {
    ServerView(client: SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true), userId: "")
  }
}

struct FileItem: Identifiable {
  let id = UUID()
  let url: URL
  var childrenItem: [FileItem]?

  var icon: String {
    if self.childrenItem == nil {
      return "photo"
    } else if self.childrenItem?.isEmpty == true {
      return "folder"
    } else {
      return "folder.fill"
    }
  }
}
