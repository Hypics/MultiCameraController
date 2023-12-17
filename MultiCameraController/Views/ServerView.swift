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
  @State private var appFileUrlList: [FileItem]? = nil

  var body: some View {
    VStack(content: {
      Divider().padding()
      HStack {
        VStack {
          Text("Session ID")
            .foregroundColor(.orange)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
          Divider()
          Text(self.client.sessionid ?? "")
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding()
        VStack {
          Text("Connected")
            .foregroundColor(.orange)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
          Divider()
          Text(self.client.connected.description)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding()
      }
      Divider().padding()
      Text("Folder List").padding()
      List(self.appFileUrlList ?? [], children: \.childrenItem) { item in
        HStack {
          Image(systemName: item.icon)
            .foregroundColor(.teal)
          Text(item.url.lastPathComponent)
            .foregroundColor(.teal)
        }
        .listRowSeparator(.hidden)
      }
    })
    .onAppear(perform: self.getAppFileUrlList)
    .onDisappear {
      // This block is not called when the view goes back.
      self.client.logout { _ in
        os_log("logout: %@", type: .info, self.client.sessionid ?? "")
      }
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
        .sorted(by: { first, second -> Bool in
          if first.url.isDirectory == second.url.isDirectory {
            return first.url.lastPathComponent < second.url.lastPathComponent
          } else {
            return first.url.isDirectory
          }
        })
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
      }
    } else {
      return nil
    }
  }
}

struct ServerView_Previews: PreviewProvider {
  static var previews: some View {
    ServerView(client: SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true))
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
