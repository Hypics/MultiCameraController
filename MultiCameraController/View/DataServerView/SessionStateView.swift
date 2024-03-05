//
//  SessionStateView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI
import SynologyKit

struct SessionStateView: View {
  @Binding var client: SynologyClient

  var body: some View {
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
  }
}
