//
//  ServerViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/5/24.
//

import Foundation
import OSLog
import SynologyKit

class ServerViewModel: ObservableObject {
  @Published var client = SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true)
  @Published var userId: String = UserDefaults.standard
    .string(forKey: "UserId") ?? ""
  @Published var userPassword: String = ""

  @Published var appFileUrlList: [FileItemInfo]?
  @Published var uploadMediaEndPoint: String = ""
  @Published var uploadProgress: Double = 0.0

  @Published var showUploadMediaToast = false

  func loginSession(_ completion: ((Result<Bool, Error>) -> Void)?) {
    if self.userId.isEmpty {
      Logger.server.error("\(self.userId) is empty")
    } else {
      Logger.server.info("Login: \(self.userId)")
      UserDefaults.standard.set(self.userId, forKey: "UserId")
      self.client.login(account: self.userId, passwd: self.userPassword) { response in
        switch response {
        case let .success(authRes):
          self.client.updateSessionID(authRes.sid)
          Logger.server.info("Synology SID: \(authRes.sid)")
          completion?(.success(true))

        case let .failure(error):
          Logger.server.error("Error: \(#function): \(error.localizedDescription)")
          completion?(.failure(error))
        }
      }
    }
  }

  func logoutSession() {
    // This block is not called when the view goes back.
    self.client.logout { _ in
      Logger.server.info("Logout: \(self.client.sessionid ?? "")")
    }
  }
}

extension ServerViewModel {
  func updateAppFileUrlList() {
    do {
      let documentDirectory = try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      Logger.server.info("DocumentDirectory: \(documentDirectory.path)")
      self.appFileUrlList = self.getFileItemList(fileUrl: documentDirectory)?
        .filter { $0.url.lastPathComponent != ".Trash" }
    } catch {
      Logger.server.error("Error: \(#function): \(error.localizedDescription)")
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
        Logger.server.error("Error: \(#function): \(error.localizedDescription)")
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
    Logger.server.info("Upload Folder: \(uploadItem.url.lastPathComponent)")
    //            self.showDownloadMediaToast = true
    guard let folderFileChildrenItems: [FileItemInfo] = uploadItem.childrenItem else {
      Logger.server.info("\(uploadItem.url.lastPathComponent) is not a folder")
      return
    }
    for childrenItem in folderFileChildrenItems {
      let destinationFolderPath = "/dataset/4DGaussians/data/" + self.userId + "/" + uploadItem
        .url.lastPathComponent
      Logger.server.info("Destination folder path: \(destinationFolderPath)")

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
            Logger.server.error("Error: \(#function): \(error.localizedDescription)")
            self.showUploadMediaToast = false
          }
        }
      )
    }
  }

  func deleteFolder(deleteItem: FileItemInfo) {
    Logger.server.info("Delete Folder or File: \(deleteItem.url.lastPathComponent)")
    do {
      try FileManager.default.removeItem(at: deleteItem.url)
    } catch {
      Logger.server.error("Error: \(#function): \(error.localizedDescription)")
    }
  }
}
