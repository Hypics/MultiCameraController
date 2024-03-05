/* Atomic.swift/Open GoPro, Version 2.0 (C) Copyright 2021 GoPro, Inc. (http://gopro.com/OpenGoPro). */
/* This copyright was auto-generated on Wed, Sep  1, 2021  5:06:09 PM */

//
//  Atomic.swift
//  MultiCameraController
//

import Foundation

@propertyWrapper
struct Atomic<Value> {
  private var value: Value
  private let lock = NSLock()

  init(wrappedValue value: Value) {
    self.value = value
  }

  var wrappedValue: Value {
    get { self.load() }
    set { self.store(newValue: newValue) }
  }

  func load() -> Value {
    self.lock.lock()
    defer { lock.unlock() }
    return self.value
  }

  mutating func store(newValue: Value) {
    self.lock.lock()
    defer { lock.unlock() }
    self.value = newValue
  }
}
