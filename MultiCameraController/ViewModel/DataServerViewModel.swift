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
}
