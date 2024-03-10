//
//  CameraManager.swift
//  MultiCameraController
//
//  Created by INHWAN WEE on 3/6/24.
//

import Foundation
import os.log

class CameraManager {
  static let instance: CameraManager = .init()

  public var cameraSerialNumberList =
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  public var cameraContainer: [any Camera] = (
    UserDefaults.standard
      .array(forKey: "GoProSerialNumberList") as? [String] ?? []
  )
  .reduce([any Camera]()) { result, item in
    var temp = result
    temp.append(GoPro(serialNumber: item))
    return temp
  }

  func getConnectedCameraCount() -> Int {
    self.cameraContainer.filter { $0.isConnected == true }.count
  }

  func addCamera(serialNumber: String) {
    if serialNumber.count == 3, serialNumber.isInt(),
       !self.cameraContainer.contains(where: { $0.serialNumber == serialNumber })
    {
      self.cameraSerialNumberList.append(serialNumber)
      self.cameraContainer
        .append(GoPro(serialNumber: serialNumber))
      self.cameraContainer.last?.checkConnection(nil)
      self.cameraContainer.last?.enableWiredUsbControl(nil)
    } else {
      os_log("%@ is not a serial number (3 digits)", type: .error, serialNumber)
    }
  }

  func moveCamera(from source: IndexSet, to destination: Int) {
    self.cameraSerialNumberList.move(fromOffsets: source, toOffset: destination)
    self.cameraContainer.move(fromOffsets: source, toOffset: destination)
  }

  func removeCamera(at offsets: IndexSet) {
    self.cameraSerialNumberList.remove(atOffsets: offsets)
    self.cameraContainer.remove(atOffsets: offsets)
  }

  func removeCamera(camera _: any Camera) {}
}
