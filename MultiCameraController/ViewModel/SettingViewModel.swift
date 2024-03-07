//
//  SettingViewModel.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/8/24.
//

import Foundation
import os.log

class SettingViewModel: ObservableObject {
  @Published var showPreset1Toast = false
  @Published var showVideoResolutionToast = false
  @Published var showVideoFpsToast = false
  @Published var showVideoDigitalLensToast = false
  @Published var showAntiFlickerToast = false
  @Published var showHypersmoothToast = false
  @Published var showHindsightToast = false
  @Published var showSystemVideoBitRateToast = false
  @Published var showSystemVideoBitDepthToast = false
  @Published var showAutoPowerDownToast = false
  @Published var showControlsModeToast = false

  func setPreset(_ cameraPreset: CameraPreset) {
    CameraManager.instance.setPresetAll(cameraPreset)
    self.showPreset1Toast.toggle()
  }

  func setVideoResolution(_ videoResolution: CameraVideoResolution) {
    CameraManager.instance.setVideoResolutionAll(videoResolution)
    self.showVideoResolutionToast.toggle()
  }

  func setFps(_ fps: CameraFps) {
    CameraManager.instance.setFpsAll(fps)
    self.showVideoFpsToast.toggle()
  }

  func setVideoDigitalLens(_ digitalLenses: CameraDigitalLenses) {
    CameraManager.instance.setDigitalLensesAll(digitalLenses)
    self.showVideoDigitalLensToast.toggle()
  }

  func setAntiFlicker(_ antiFlicker: CameraAntiFlicker) {
    CameraManager.instance.setAntiFlickerAll(antiFlicker)
    self.showAntiFlickerToast.toggle()
  }

  func setHypersmooth(_ hypersmooth: CameraHypersmooth) {
    CameraManager.instance.setHypersmoothAll(hypersmooth)
    self.showHypersmoothToast.toggle()
  }

  func setHindsight(_ hindsight: CameraHindsight) {
    CameraManager.instance.setHindsightAll(hindsight)
    self.showHindsightToast.toggle()
  }

  func setVideoBitRate(_ videoBitRate: CameraVideoBitRate) {
    CameraManager.instance.setVideoBitRateAll(videoBitRate)
    self.showSystemVideoBitRateToast.toggle()
  }

  func setVideoBitDepth(_ videoBitDepth: CameraVideoBitDepth) {
    CameraManager.instance.setVideoBitDepthAll(videoBitDepth)
    self.showSystemVideoBitDepthToast.toggle()
  }

  func setAutoPowerDown(_ autoPowerDown: CameraAutoPowerDown) {
    CameraManager.instance.setAutoPowerDownAll(autoPowerDown)
    self.showAutoPowerDownToast.toggle()
  }

  func setControlsMode(_ controlMode: CameraControlMode) {
    CameraManager.instance.setControlModeAll(controlMode)
    self.showControlsModeToast.toggle()
  }
}
