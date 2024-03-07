//
//  mainView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import SwiftUI

struct MainView: View {
  @StateObject var multiCameraViewModel = MultiCameraViewModel()
  @StateObject var dataServerViewModel = DataServerViewModel()

  @State var showMultiCameraView = false

  var body: some View {
    NavigationStack(path: self.$multiCameraViewModel.path) {
      ZStack {
        Color.hauntedMeadow

        Button(
          action: {
            self.multiCameraViewModel.path.append(StackView(view: .multiCameraView))
          },
          label: {
            VStack {
              Text("Hypics").font(.custom("Archivo", size: 120)).foregroundStyle(Color.skyishMyish)
                .padding(5)
              Text("Step to the Next Level Immersive Experience").font(.custom("Archivo", size: 44))
                .foregroundStyle(.white)
                .padding(5)
              Text("Hyper Pictures").font(.custom("Archivo", size: 24)).foregroundStyle(Color.skyishMyish)
                .padding([.top, .leading, .trailing], 5)
                .padding([.bottom], 100)
            }
          }
        )
      }
      .ignoresSafeArea()
      .navigationDestination(for: StackView.self) { stackView in
        switch stackView.view {
        case .mainView:
          MainView()

        case .multiCameraView:
          MultiCameraView(
            multiCameraViewModel: self.multiCameraViewModel,
            dataServerViewModel: self.dataServerViewModel
          )

        case .cameraView:
          CameraView(cameraViewModel: CameraViewModel(
            camera: stackView
              .data as? (any Camera) ?? GoPro(serialNumber: "")
          ))

        case .settingView:
          SettingView(multiCameraViewModel: self.multiCameraViewModel)

        case .dataServerView:
          DataServerView(dataServerViewModel: self.dataServerViewModel)
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
