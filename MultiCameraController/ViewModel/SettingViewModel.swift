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

  func setPreset(_ cameraPreset: CameraPreset, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setPresetAll(cameraPreset, selectedCameraList)
    self.showPreset1Toast.toggle()
  }

  func setVideoResolution(_ videoResolution: CameraVideoResolution, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setVideoResolutionAll(videoResolution, selectedCameraList)
    self.showVideoResolutionToast.toggle()
  }

  func setFps(_ fps: CameraFps, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setFpsAll(fps, selectedCameraList)
    self.showVideoFpsToast.toggle()
  }

  func setVideoDigitalLens(_ digitalLenses: CameraDigitalLenses, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setDigitalLensesAll(digitalLenses, selectedCameraList)
    self.showVideoDigitalLensToast.toggle()
  }

  func setAntiFlicker(_ antiFlicker: CameraAntiFlicker, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setAntiFlickerAll(antiFlicker, selectedCameraList)
    self.showAntiFlickerToast.toggle()
  }

  func setHypersmooth(_ hypersmooth: CameraHypersmooth, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setHypersmoothAll(hypersmooth, selectedCameraList)
    self.showHypersmoothToast.toggle()
  }

  func setHindsight(_ hindsight: CameraHindsight, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setHindsightAll(hindsight, selectedCameraList)
    self.showHindsightToast.toggle()
  }

  func setVideoBitRate(_ videoBitRate: CameraVideoBitRate, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setVideoBitRateAll(videoBitRate, selectedCameraList)
    self.showSystemVideoBitRateToast.toggle()
  }

  func setVideoBitDepth(_ videoBitDepth: CameraVideoBitDepth, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setVideoBitDepthAll(videoBitDepth, selectedCameraList)
    self.showSystemVideoBitDepthToast.toggle()
  }

  func setAutoPowerDown(_ autoPowerDown: CameraAutoPowerDown, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setAutoPowerDownAll(autoPowerDown, selectedCameraList)
    self.showAutoPowerDownToast.toggle()
  }

  func setControlsMode(_ controlMode: CameraControlMode, _ selectedCameraList: [any Camera]) {
    CameraManager.instance.setControlModeAll(controlMode, selectedCameraList)
    self.showControlsModeToast.toggle()
  }
}
