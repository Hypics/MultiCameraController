//
//  SoundUtil.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import AudioToolbox
import Foundation

// MARK: - Alarm sounds

let CAMERA_SHUTTER_SOUND: SystemSoundID = 1_108
let MISSION_FINISH_SOUND: SystemSoundID = 1_007
let ERROR_SOUND: SystemSoundID = 1_304

func invokeMissionFinishSound() {
  AudioServicesPlaySystemSound(MISSION_FINISH_SOUND)
}

func invokeErrorSound() {
  AudioServicesPlaySystemSound(ERROR_SOUND)
}

func invokeCameraShutterSound() {
  AudioServicesPlaySystemSound(CAMERA_SHUTTER_SOUND)
}
