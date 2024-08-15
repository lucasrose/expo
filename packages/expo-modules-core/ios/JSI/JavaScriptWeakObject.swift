// Copyright 2024-present 650 Industries. All rights reserved.

@_implementationOnly import ExpoModulesCoreCxx

@objc
public class JavaScriptWeakObject: NSObject {
  internal weak var _runtime: JavaScriptRuntime?

  internal var runtime: JavaScriptRuntime {
    return _runtime!
  }

  #if canImport(reacthermes)
  let ptr: facebook.jsi.WeakObject
  #else
  var ptr: facebook.jsi.Object
  #endif

  init(runtime: JavaScriptRuntime, ptr: expo.ObjectSharedPtr) {
    self._runtime = runtime

    #if canImport(reacthermes)
    self.ptr = facebook.jsi.WeakObject(&runtime.pointee, ptr.pointee)
    #else
    if expo.common.isWeakRefSupported(&runtime.pointee) {
      self.ptr = expo.common.createWeakRef(&runtime.pointee, &ptr)
    } else {
      self.ptr = ptr
    }
    #endif
  }

  public func lock() -> JavaScriptObject? {
    #if canImport(reacthermes)
    let value = ptr.lock(&runtime.pointee)
    #else
    let value = expo.common.isWeakRefSupported(&runtime.pointee)
      ? expo.common.derefWeakRef(&runtime.pointee, &ptr)
      : facebook.jsi.Value(&runtime.pointee, ptr)
    #endif

    if value.isUndefined() {
      return nil
    }
    var object = value.asObject(&runtime.pointee)
    return JavaScriptObject(runtime: runtime, pointee: &object)
  }
}
