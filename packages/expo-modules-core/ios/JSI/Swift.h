// Copyright 2024-present 650 Industries. All rights reserved.

#ifdef __cplusplus

// This is borrowed from ExpoModulesCoreJSI-Swift.h
#if __has_include(<swiftToCxx/_SwiftCxxInteroperability.h>)
#include <swiftToCxx/_SwiftCxxInteroperability.h>
// Look for the C++ interop support header relative to clang's resource dir:
//  '<toolchain>/usr/lib/clang/<version>/include/../../../swift/swiftToCxx'.
#elif __has_include(<../../../swift/swiftToCxx/_SwiftCxxInteroperability.h>)
#include <../../../swift/swiftToCxx/_SwiftCxxInteroperability.h>
#elif __has_include(<../../../../../lib/swift/swiftToCxx/_SwiftCxxInteroperability.h>)
//  '<toolchain>/usr/local/lib/clang/<version>/include/../../../../../lib/swift/swiftToCxx'.
#include <../../../../../lib/swift/swiftToCxx/_SwiftCxxInteroperability.h>
#endif

#define SWIFT_SYMBOL(usrValue) SWIFT_SYMBOL_MODULE_USR("swift", usrValue)

namespace ExpoModulesCoreJSI SWIFT_PRIVATE_ATTR SWIFT_SYMBOL_MODULE("ExpoModulesCoreJSI") {
  class SWIFT_SYMBOL("s:18ExpoModulesCoreJSI15JavaScriptValueC") JavaScriptValue;
  class SWIFT_SYMBOL("s:18ExpoModulesCoreJSI16JavaScriptObjectC") JavaScriptObject;
  class SWIFT_SYMBOL("s:18ExpoModulesCoreJSI17JavaScriptRuntimeC") JavaScriptRuntime;
  class SWIFT_SYMBOL("s:18ExpoModulesCoreJSI20JavaScriptWeakObjectC") JavaScriptWeakObject;
} // end namespace

#if __has_include(<ExpoModulesCoreJSI/ExpoModulesCoreJSI-Swift.h>)
#import <ExpoModulesCoreJSI/ExpoModulesCoreJSI-Swift.h>
#elif __has_include(<ExpoModulesCoreJSI-Swift.h>)
#import <ExpoModulesCoreJSI-Swift.h>
#elif __has_include("ExpoModulesCoreJSI-Swift.h")
#import "ExpoModulesCoreJSI-Swift.h"
#endif

#endif // __cplusplus
