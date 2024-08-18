// Copyright 2024-present 650 Industries. All rights reserved.

#import "AppleCxxInteropUtils.h"
#import "Swift.h"

namespace expo {

CallInvokerSharedPtr makeSharedTestingSyncJSCallInvoker(RuntimeSharedPtr runtime) {
  auto callInvoker = std::make_shared<TestingSyncJSCallInvoker>(runtime);
  return std::dynamic_pointer_cast<react::CallInvoker>(callInvoker);
}

}

//namespace ExpoModulesCoreJSI {

//JavaScriptRuntime init(jsi::Runtime &runtime, expo::CallInvokerSharedPtr callInvoker) {
//  return JavaScriptRuntime
//}

//}
