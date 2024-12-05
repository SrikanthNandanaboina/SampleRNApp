//
//  UpswingModuleEmitter.m
//  MyApp
//
//  Created by Srikanth N on 04/12/24.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(UpswingModuleEmitter, RCTEventEmitter)
RCT_EXTERN_METHOD(supportedEvents)
RCT_EXTERN_METHOD(upswingSuccess:(NSString *)ici gst:(NSString *)gst)
RCT_EXTERN_METHOD(upswingFailure)
RCT_EXTERN_METHOD(launchUpswing)
RCT_EXTERN_METHOD(launchUpswingViaDeeplink:(NSString *)deeplink)
RCT_EXTERN_METHOD(logoutUpswing)
@end
