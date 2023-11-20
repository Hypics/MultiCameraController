//
//  SettingsView.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/20/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss)
    private var dismiss
    var peripheral: Peripheral?
    @State private var showCameraWiFiView = false
    var body: some View {
        VStack(content: {
            Text("Settings View..").padding()
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
