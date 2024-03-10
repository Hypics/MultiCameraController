//
//  ViewExtension.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import SwiftUI

extension View {
  func cardModifier() -> some View {
    self.modifier(CardModifier())
  }

  func blinkBorderAnimation(
    _ color: Color?,
    lineWidth: CGFloat,
    cornerRadius: CGFloat,
    duration: Double,
    repeatCount: Int
  ) -> some View {
    self.overlay(BlinkingBorder(
      color: color,
      lineWidth: lineWidth,
      cornerRadius: cornerRadius,
      duration: duration,
      repeatCount: repeatCount
    ))
  }
}

struct CardModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(
        RoundedRectangle(cornerRadius: 20)
          .foregroundColor(.white)
          .shadow(color: .black, radius: 4)
          .opacity(0.2)
      )
  }
}

struct BlinkingBorder: View {
  let color: Color?
  let lineWidth: CGFloat
  let cornerRadius: CGFloat
  let duration: TimeInterval
  let repeatCount: Int

  @State private var isAnimating = false

  var body: some View {
    if let color = self.color {
      RoundedRectangle(cornerRadius: self.cornerRadius)
        .strokeBorder(color, lineWidth: self.isAnimating ? self.lineWidth : 0)
        .onAppear {
          withAnimation(
            Animation.linear(duration: self.duration)
              .repeatCount(self.repeatCount, autoreverses: false)
          ) {
            self.isAnimating.toggle()
          }
        }
    } else {
      RoundedRectangle(cornerRadius: self.cornerRadius)
        .strokeBorder(
          LinearGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          ),
          lineWidth: self.isAnimating ? self.lineWidth : 0
        )
        .onAppear {
          withAnimation(
            Animation.linear(duration: self.duration)
              .repeatCount(self.repeatCount, autoreverses: false)
          ) {
            self.isAnimating.toggle()
          }
        }
    }
  }
}
