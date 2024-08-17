// Copyright 2022-present 650 Industries. All rights reserved.

//@_implementationOnly import ExpoModulesCoreCxx

/**
 Enum with available kinds of values. It's almost the same as a result of "typeof"
 in JavaScript, however `null` has its own kind (typeof null == "object").
 */
public enum JavaScriptValueKind: String {
  case undefined
  case null
  case bool
  case number
  case symbol
  case string
  case function
  case object
}

//@objc
public class JavaScriptValue: @unchecked Sendable {
  public static let undefined = JavaScriptValue(value: .undefined())
  public static let null = JavaScriptValue(value: .null())

  private weak var _runtime: JavaScriptRuntime?
  internal let value: facebook.jsi.Value

  internal var runtime: JavaScriptRuntime {
    return _runtime!
  }

  init(runtime: JavaScriptRuntime, value: consuming facebook.jsi.Value) {
    self._runtime = runtime
    self.value = value
  }

  init(value: consuming facebook.jsi.Value) {
    self.value = value
  }

  func copy() -> facebook.jsi.Value {
    return facebook.jsi.Value(&runtime.pointee, value)
  }

  public func isUndefined() -> Bool {
    return value.isUndefined()
  }

  public func isNull() -> Bool {
    return value.isNull()
  }

  public func isBool() -> Bool {
    return value.isBool()
  }

  public func isNumber() -> Bool {
    return value.isNumber()
  }

  public func isString() -> Bool {
    return value.isString()
  }

  public func isSymbol() -> Bool {
    return value.isSymbol()
  }

  public func isObject() -> Bool {
    return value.isObject()
  }

  public func isFunction() -> Bool {
    guard value.isObject() else {
      return false
    }
    return value.getObject(&runtime.pointee).isFunction(&runtime.pointee)
  }

  public func isTypedArray() -> Bool {
    guard value.isObject() else {
      return false
    }
    return expo.isTypedArray(&runtime.pointee, value.getObject(&runtime.pointee))
  }

  // MARK: - Type casting

  public func getRaw() -> Any {
    fatalError()
  }

  public func getBool() -> Bool {
    return value.getBool()
  }

  public func getInt() -> Int {
    return Int(value.getNumber())
  }

  public func getDouble() -> Double {
    return value.getNumber()
  }

  public func getString() -> String {
    return String(value.getString(&runtime.pointee).utf8(&runtime.pointee))
  }

  public func getArray() -> [JavaScriptValue] {
    let jsiArray = value.getObject(&runtime.pointee).getArray(&runtime.pointee)
    let size = jsiArray.size(&runtime.pointee)

    return (0..<size).map { index in
      let item = jsiArray.getValueAtIndex(&runtime.pointee, index)
      return JavaScriptValue(runtime: runtime, value: item)
    }
  }

  public func getDictionary() -> [String: Any] {
    var object = value.getObject(&runtime.pointee)
    return JSIUtils.convertObjectToDictionary(runtime: &runtime.pointee, object: &object)
  }

  public func getObject() -> JavaScriptObject {
    return JavaScriptObject(runtime: runtime, pointee: value.getObject(&runtime.pointee))
  }

//  func getFunction() -> JavaScriptFunction<Any> {
//    fatalError()
//  }

  public func getTypedArray() -> JavaScriptTypedArray? {
    guard isTypedArray() else {
      return nil
    }
    return JavaScriptTypedArray(runtime: runtime, pointee: value.asObject(&runtime.pointee))
  }

  // MARK: - old extension

  public var kind: JavaScriptValueKind {
    switch true {
    case isUndefined():
      return .undefined
    case isNull():
      return .null
    case isBool():
      return .bool
    case isNumber():
      return .number
    case isSymbol():
      return .symbol
    case isString():
      return .string
    case isFunction():
      return .function
    default:
      return .object
    }
  }

//  func asBool() throws -> Bool {
//    if isBool() {
//      return getBool()
//    }
//    throw JavaScriptValueConversionException((kind: kind, target: "Bool"))
//  }

  public func asInt() throws -> Int {
    if isNumber() {
      return getInt()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "Int"))
  }

  public func asDouble() throws -> Double {
    if isNumber() {
      return getDouble()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "Double"))
  }

  public func asString() throws -> String {
    if isString() {
      return getString()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "String"))
  }

  public func asArray() throws -> [JavaScriptValue?] {
    if isObject() {
      return getArray()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "Array"))
  }

  public func asDict() throws -> [String: Any] {
    if isObject() {
      return getDictionary()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "Dict"))
  }

  public func asObject() throws -> JavaScriptObject {
    if isObject() {
      return getObject()
    }
    fatalError()
//    throw JavaScriptValueConversionException((kind: kind, target: "Object"))
  }

//  func asFunction() throws -> JavaScriptFunction<Any> {
//    if isFunction() {
//      return getFunction()
//    }
//    throw JavaScriptValueConversionException((kind: kind, target: "Function"))
//  }

//  func asTypedArray() throws -> JavaScriptTypedArray {
//    if let typedArray = getTypedArray() {
//      return typedArray
//    }
//    throw JavaScriptValueConversionException((kind: kind, target: "TypedArray"))
//  }

  // MARK: - AnyJavaScriptValue

//  internal static func convert(from value: JavaScriptValue, appContext: AppContext) throws -> Self {
//    // It's already a `JavaScriptValue` so it should always pass through.
//    if let value = value as? Self {
//      return value
//    }
//    throw JavaScriptValueConversionException((kind: value.kind, target: String(describing: Self.self)))
//  }
}

//internal final class JavaScriptValueConversionException: GenericException<(kind: JavaScriptValueKind, target: String)> {
//  override var reason: String {
//    "Cannot represent a value of kind '\(param.kind)' as \(param.target)"
//  }
//}
