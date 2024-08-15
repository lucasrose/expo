// Copyright 2024-present 650 Industries. All rights reserved.

#import <React/RCTBridgeModule.h>
#import <ExpoModulesCore/EXNativeModulesProxy.h>
#import <ExpoModulesCore/EXModuleRegistry.h>

@class AppContext;

@interface ExpoBridgeModule : NSObject <RCTBridgeModule>

@property (nonatomic, nullable, strong) AppContext *appContext;

- (nonnull instancetype)initWithAppContext:(nonnull AppContext *) appContext;

- (void)legacyProxyDidSetBridge:(nonnull EXNativeModulesProxy *)moduleProxy
           legacyModuleRegistry:(nonnull EXModuleRegistry *)moduleRegistry;

@end
