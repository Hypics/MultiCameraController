//
//  LoginView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

struct LoginView: View {
  @ObservedObject var serverViewModel: ServerViewModel
  @Binding var viewInfoList: [ViewInfo]

  var body: some View {
    HStack {
      Spacer()
      Spacer()
      Text("Synology NAS")
        .padding(5)
      TextField("ID", text: self.$serverViewModel.userId)
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .frame(width: 140)
        .fixedSize(horizontal: true, vertical: false)
        .padding(5)
      SecureField("Password", text: self.$serverViewModel.userPassword)
        .padding(10)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 1.0)
        )
        .frame(width: 140)
        .fixedSize(horizontal: true, vertical: false)
        .padding(5)
      Spacer()
      Button(
        action: {
          self.serverViewModel.loginSession { result in
            switch result {
            case .success:
              self.viewInfoList.append(ViewInfo(view: .serverView))

            case .failure:
              break
            }
          }
        },
        label: {
          HStack {
            Image(systemName: "network")
              .foregroundColor(.teal)
            Text("Login")
              .foregroundColor(.teal)
          }
        }
      )
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 15)
          .stroke(.gray, lineWidth: 1.0)
      )
      .padding(5)
      Spacer()
      Spacer()
    }
  }
}
