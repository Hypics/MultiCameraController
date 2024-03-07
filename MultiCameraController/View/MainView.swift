//
//  MainView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import SwiftUI

struct MainView: View {
  @StateObject var dataServerViewModel = DataServerViewModel()
  @StateObject var multiCameraViewModel = MultiCameraViewModel()
  @StateObject var settingViewModel = SettingViewModel()
  @State var viewInfoList: [ViewInfo] = []

  var body: some View {
    NavigationStack(path: self.$viewInfoList) {
      ZStack {
        Color.hauntedMeadow

        Button(
          action: {
            self.viewInfoList.append(ViewInfo(view: .multiCameraView))
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
      .navigationDestination(for: ViewInfo.self) { viewInfo in
        switch viewInfo.view {
        case .mainView:
          MainView()

        case .multiCameraView:
          MultiCameraView(
            multiCameraViewModel: self.multiCameraViewModel,
            dataServerViewModel: self.dataServerViewModel,
            viewInfoList: self.$viewInfoList
          )

        case .cameraView:
          CameraView(cameraViewModel: CameraViewModel(
            camera: viewInfo
              .data as? (any Camera) ?? GoPro(serialNumber: "")
          ))

        case .settingView:
          SettingView(settingViewModel: self.settingViewModel)

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
