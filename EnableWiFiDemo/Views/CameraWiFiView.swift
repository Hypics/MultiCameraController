//
//  CameraWiFiView.swift
//  EnableWiFiDemo
//
//  Created by INHWAN WEE on 11/18/23.
//

import SwiftUI
import os.log

struct CameraWiFiView: View {
    @Environment(\.dismiss)
    private var dismiss
    var peripheral: Peripheral?
    var body: some View {
            VStack(content: {
                Text("Deep Frost Testing..").padding()
                Button(action: {
                    os_log("Requesting Media List...", type: .info)
                    Peripheral.requestWiFiCommand(command: .get_media_list, { error in
                        if error != nil {
                            os_log("Error: %@", type: .error, error! as CVarArg)
                            return
                        }
                    })
                }, label: {
                    Text("Get Media List")
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(peripheral?.name ?? "").fontWeight(.bold)
                    }
                }.padding()
                Button(action: {
                    os_log("Go back...", type: .info)
                    dismiss()
                }, label: {
                    Text("Go back")
                })
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(peripheral?.name ?? "").fontWeight(.bold)
                    }
                }.padding()
            })
        }
    
}

struct CameraWiFiView_Previews: PreviewProvider {
    static var previews: some View {
        CameraWiFiView()
    }
}
