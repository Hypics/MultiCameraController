//
//  MainView.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/7/24.
//

import SwiftUI

struct MainView: View {
  @State var viewInfoList: [ViewInfo] = []

  @State private var isServerButtonTapped = false
  @State private var isCameraButtonTapped = false

  var body: some View {
    NavigationStack(path: self.$viewInfoList) {
      ZStack {
        Color.hauntedMeadow

        VStack {
          VStack {
            Spacer()
            Text("Hypics").font(.custom("Archivo", size: 120, relativeTo: .largeTitle))
              .foregroundStyle(Color.skyishMyish)
              .padding(10)
            Text("Step to the Next Level Immersive Experience")
              .font(.custom("Archivo", size: 44, relativeTo: .headline))
              .foregroundStyle(.white)
              .padding(5)
            Text("Hyper Pictures").font(.custom("Archivo", size: 24, relativeTo: .subheadline))
              .foregroundStyle(Color.skyishMyish)
              .padding(5)
            Spacer()
            Spacer()
            Spacer()
          }
          .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.36)
          .contentShape(Rectangle())
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .strokeBorder(
                Color.skyishMyish,
                lineWidth: 3
              )
          )

          HStack {
            Spacer()
            Spacer()
            Button(
              action: {
                withAnimation(.easeOut(duration: 1.0)) {
                  self.isServerButtonTapped = true
                } completion: {
                  self.viewInfoList.append(.init(view: .serverView))
                }
              },
              label: {
                Text("Servers")
                  .font(.custom("Archivo", size: 44, relativeTo: .headline))
                  .foregroundStyle(.white)
                  .frame(width: UIScreen.screenWidth * 0.32, height: UIScreen.screenHeight * 0.08)
              }
            )
            .buttonStyle(.bordered)
            .opacity(self.isServerButtonTapped ? 0 : 1)

            Spacer()
            Button(
              action: {
                withAnimation(.easeOut(duration: 1.0)) {
                  self.isCameraButtonTapped = true
                } completion: {
                  self.viewInfoList.append(.init(view: .multiCameraView))
                }
              },
              label: {
                Text("Cameras")
                  .font(.custom("Archivo", size: 44, relativeTo: .headline))
                  .foregroundStyle(.white)
                  .frame(width: UIScreen.screenWidth * 0.32, height: UIScreen.screenHeight * 0.08)
              }
            )
            .buttonStyle(.bordered)
            .opacity(self.isCameraButtonTapped ? 0 : 1)
            Spacer()
            Spacer()
          }
          .padding(50)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .navigationTitle("Hypics")
      .navigationBarHidden(true)
      .ignoresSafeArea()
      .navigationDestination(for: ViewInfo.self) { viewInfo in
        switch viewInfo.view {
        case .mainView:
          MainView()

        case .multiCameraView:
          MultiCameraView()

        case .serverView:
          ServerView()
        }
      }
      .onAppear {
        self.isServerButtonTapped = false
        self.isCameraButtonTapped = false
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
