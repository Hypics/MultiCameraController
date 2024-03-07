//
//  DataServerViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/5/24.
//

import Foundation
import os.log
import SynologyKit

class DataServerViewModel: ObservableObject {
  @Published var showDataServerView = false
  @Published var client = SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true)
  @Published var userId: String = UserDefaults.standard
    .string(forKey: "UserId") ?? ""
  @Published var userPassword: String = ""

  @Published var appFileUrlList: [FileItemInfo]?
  @Published var uploadMediaEndPoint: String = ""
  @Published var uploadProgress: Double = 0.0

  @Published var showUploadMediaToast = false

  func loginSession() {
    if self.userId.isEmpty {
      os_log("%@ is empty", type: .error, self.userId)
    } else {
      os_log("login: %@", type: .info, self.userId)
      UserDefaults.standard.set(self.userId, forKey: "UserId")
      self.client.login(account: self.userId, passwd: self.userPassword) { response in
        switch response {
        case let .success(authRes):
          self.client.updateSessionID(authRes.sid)
          os_log("Synology SID: %@", type: .error, authRes.sid)
          self.showDataServerView = true

        case let .failure(error):
          os_log("Error: %@", type: .error, error.description)
        }
      }
    }
  }

  func logoutSession() {
    // This block is not called when the view goes back.
    self.client.logout { _ in
      os_log("logout: %@", type: .info, self.client.sessionid ?? "")
    }
  }
}

extension DataServerViewModel {
  func getAppFileUrlList() {
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

  func getFileItemList(fileUrl: URL) -> [FileItemInfo]? {
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
        return fileContentsUrlList.reduce([FileItemInfo]()) { result, fileContentsUrl in
          var temp = result
          temp.append(FileItemInfo(url: fileContentsUrl, childrenItem: self.getFileItemList(fileUrl: fileContentsUrl)))
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

  func uploadFolder(uploadItem: FileItemInfo) {
    os_log("Upload Folder: %@", type: .info, uploadItem.url.lastPathComponent)
    //            self.showDownloadMediaToast = true
    guard let folderFileChildrenItems: [FileItemInfo] = uploadItem.childrenItem else {
      os_log("%@ is not directory", type: .info, uploadItem.url.lastPathComponent)
      return
    }
    for childrenItem in folderFileChildrenItems {
      let destinationFolderPath = "/dataset/4DGaussians/data/" + self.userId + "/" + uploadItem
        .url.lastPathComponent
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
          self.uploadMediaEndPoint = "[" + self.userId + "] " + uploadItem.url
            .lastPathComponent + "/" + childrenItem.url
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
  }

  func deleteFolder(deleteItem: FileItemInfo) {
    os_log("Delete Folder or File: %@", type: .info, deleteItem.url.lastPathComponent)
    do {
      try FileManager.default.removeItem(at: deleteItem.url)
    } catch {
      os_log("Could not remove item: %@", type: .info, error.localizedDescription)
    }
  }
}
