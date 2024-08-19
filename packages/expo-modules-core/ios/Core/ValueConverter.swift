// Copyright 2024-present 650 Industries. All rights reserved.

public struct ValueConverter {
  let appContext: AppContext

  /**
   Preliminarily casts the given JavaScriptValue to a non-JS value.
   It **must** be run on the thread used by the JavaScript runtime.
   */
  func toNative(_ value: JavaScriptValue, _ type: AnyDynamicType) throws -> Any {
    return try type.cast(jsValue: value, appContext: appContext)
  }

  /**
   Casts the given JS values to non-JS values.
   It **must** be run on the thread used by the JavaScript runtime.
   */
  func toNative(_ values: [JavaScriptValue], _ types: [AnyDynamicType]) throws -> [Any] {
    return try values.enumerated().map { index, value in
      let type = types[index]

      do {
        return try toNative(value, types[index])
      } catch {
        throw ArgumentCastException((index: index, type: type)).causedBy(error)
      }
    }
  }

  /**
   Converts the given value to the type compatible with JavaScript.
   */
  func toJS<ValueType>(_ value: ValueType, _ type: AnyDynamicType) throws -> JavaScriptValue {
    let result = Conversions.convertFunctionResult(value, appContext: appContext, dynamicType: type)
    return try type.castToJS(result, appContext: appContext)
  }
}
