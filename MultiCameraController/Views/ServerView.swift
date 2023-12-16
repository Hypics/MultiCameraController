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
  @State private var folderList: [String] = []

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
      HStack {
        Button(action: {
          os_log("Upload", type: .info)
        }, label: {
          VStack {
            Image(systemName: "square.and.arrow.up")
              .foregroundColor(.teal)
              .padding([.top, .bottom], 7)
              .padding([.leading, .trailing], 10)
            Text("Upload")
              .foregroundColor(.teal)
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          }
        })
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding()
        Button(action: {
          os_log("Request task", type: .info)
        }, label: {
          VStack {
            Image(systemName: "figure.run")
              .foregroundColor(.pink)
              .padding([.top, .bottom], 7)
              .padding([.leading, .trailing], 10)
            Text("Request task")
              .foregroundColor(.pink)
              .padding([.top, .bottom], 5)
              .padding([.leading, .trailing], 10)
          }
        })
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .padding()
      }
      Divider().padding()
      Text("Folder List").padding()
      List {
        ForEach(self.folderList, id: \.self) { folder in
          Button(action: {
            os_log("Folder: %@", type: .info, folder)
          }, label: {
            HStack {
              Spacer()
              Image(systemName: "photo")
                .foregroundColor(.teal)
              Text(folder)
                .foregroundColor(.teal)
              Spacer()
            }
          })
        }
        .listRowSeparator(.hidden)
      }
    })
    .onDisappear {
      // This block is not called when the view goes back.
      self.client.logout { _ in
        os_log("logout: %@", type: .info, self.client.sessionid ?? "")
      }
    }
  }
}

struct ServerView_Previews: PreviewProvider {
  static var previews: some View {
    ServerView(client: SynologyClient(host: "ds918pluswee.synology.me", port: 5_001, enableHTTPS: true))
  }
}
