// Copyright 2024-present 650 Industries. All rights reserved.

#pragma once

#ifdef __cplusplus

#include <jsi/jsi.h>
#include <ReactCommon/CallInvoker.h>

#if __has_include(<reacthermes/HermesExecutorFactory.h>)
#import <reacthermes/HermesExecutorFactory.h>
#else
#import <jsi/JSCRuntime.h>
#endif

#include "TestingSyncJSCallInvoker.h"

namespace jsi = facebook::jsi;
namespace react = facebook::react;

namespace expo {

typedef std::shared_ptr<jsi::Runtime> RuntimeSharedPtr;
typedef std::shared_ptr<jsi::Object> ObjectSharedPtr;
typedef std::shared_ptr<react::CallInvoker> CallInvokerSharedPtr;

void setProperty(jsi::Runtime &runtime, const jsi::Object &object, const char *name, const jsi::Value &value) {
  object.setProperty(runtime, name, value);
}

void setProperty(jsi::Runtime &runtime, const jsi::Object &object, const char *name, const jsi::Object &value) {
  object.setProperty(runtime, name, value);
}

RuntimeSharedPtr makeRuntime() {
  #if __has_include(<reacthermes/HermesExecutorFactory.h>)
  // TODO: Polyfill setImmediate, see EXJavaScriptRuntime.mm
  return facebook::hermes::makeHermesRuntime();
  #else
  return jsc::makeJSCRuntime();
  #endif
}

CallInvokerSharedPtr makeSharedTestingSyncJSCallInvoker(RuntimeSharedPtr runtime);

RuntimeSharedPtr makeShared(jsi::Runtime &runtime) {
  return std::shared_ptr<jsi::Runtime>(std::shared_ptr<jsi::Runtime>(), &runtime);
}

ObjectSharedPtr makeShared(jsi::Runtime &runtime, jsi::Object &object) {
  auto value = jsi::Value(runtime, object);
  return std::make_shared<jsi::Object>(value.getObject(runtime));
}

}; // namespace expo

//namespace ExpoModulesCoreJSI {
//class JavaScriptRuntime;
//JavaScriptRuntime init(jsi::Runtime &runtime, expo::CallInvokerSharedPtr callInvoker);
//}

#endif // __cplusplus
