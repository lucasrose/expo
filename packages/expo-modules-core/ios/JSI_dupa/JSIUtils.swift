// Copyright 2024-present 650 Industries. All rights reserved.

//@_implementationOnly import ExpoModulesCoreCxx

public enum PropertyDescriptorOption {
  case configurable
  case enumerable
  case writable
}

public struct JSIUtils {
  static public func createNativeModuleObject(_ runtime: JavaScriptRuntime) -> JavaScriptObject {
    return JavaScriptObject(runtime: runtime, pointee: expo.NativeModule.createInstance(&runtime.pointee))
  }

  static func preparePropertyDescriptor(runtime: inout facebook.jsi.Runtime) -> facebook.jsi.Object {
    let descriptor = facebook.jsi.Object(&runtime)

    expo.setProperty(&runtime, descriptor, "configurable", facebook.jsi.Value(true))
    expo.setProperty(&runtime, descriptor, "enumerable", facebook.jsi.Value(true))
    expo.setProperty(&runtime, descriptor, "writable", facebook.jsi.Value(true))

    return descriptor
  }

  static func convertJSIValue(runtime: inout facebook.jsi.Runtime, value: inout facebook.jsi.Value) -> Any {
    if value.isUndefined() || value.isNull() {
      return Optional<Any>.none as Any
    }
    if value.isBool() {
      return value.getBool()
    }
    if value.isNumber() {
      return value.getNumber()
    }
    if value.isString() {
      return String(value.getString(&runtime).utf8(&runtime))
    }
    if value.isObject() {
      let object = value.getObject(&runtime)

      if object.isArray(&runtime) {
        var array = object.getArray(&runtime)
        return convertArray(runtime: &runtime, array: &array)
      }
      if object.isFunction(&runtime) {
        fatalError("Converting a function is not supported yet")
      }
    }
    fatalError("Unsupported JSI value kind")
  }

  static func convertToJSIValue(runtime: inout facebook.jsi.Runtime, value: Any) -> facebook.jsi.Value {
    if let value = value as? JavaScriptValue {
      return value.copy()
    }
    if let value = value as? JavaScriptObject {
      return facebook.jsi.Value(&runtime, value.ptr.pointee)
    }
    if let value = value as? JavaScriptWeakObject {
      return facebook.jsi.Value(&runtime, value.lock()!.get())
    }
    if let value = value as? String {
      let string = facebook.jsi.String.createFromUtf8(&runtime, std.string(Array(value.utf8CString)))
      return facebook.jsi.Value(&runtime, string)
    }
    if let value = value as? Double {
      return facebook.jsi.Value(value)
    }
    if let value = value as? Bool {
      return facebook.jsi.Value(value)
    }
    // TODO: Add missing ones
    return facebook.jsi.Value.undefined()
  }

  static func convertArray(runtime: inout facebook.jsi.Runtime, array: inout facebook.jsi.Array) -> [Any] {
    let size = array.size(&runtime)

    return (0..<size).map { index in
      var item = array.getValueAtIndex(&runtime, index)
      return convertJSIValue(runtime: &runtime, value: &item)
    }
  }

  static func convertObjectToDictionary(runtime: inout facebook.jsi.Runtime, object: inout facebook.jsi.Object) -> [String: Any] {
    let propertyNames = object.getPropertyNames(&runtime)
    let size = propertyNames.size(&runtime)

    return (0..<size).reduce(into: [:]) { partialResult, index in
      let propertyName = propertyNames.getValueAtIndex(&runtime, index).getString(&runtime)
      var propertyValue = object.getProperty(&runtime, propertyName)
      let key = String(propertyName.utf8(&runtime))

      partialResult[key] = convertJSIValue(runtime: &runtime, value: &propertyValue)
    }
  }

  static public func emitEvent(_ event: String, to object: JavaScriptObject, withArguments arguments: [Any], in runtime: JavaScriptRuntime) {
    fatalError()
//    expo.EventEmitter.emitEvent(&rt, &jsiObject, event, [])
  }
}
