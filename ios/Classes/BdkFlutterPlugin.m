#import "BdkFlutterPlugin.h"
#if __has_include(<bdk_flutter/bdk_flutter-Swift.h>)
#import <bdk_flutter/bdk_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bdk_flutter-Swift.h"
#endif

@implementation BdkFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBdkFlutterPlugin registerWithRegistrar:registrar];
}
@end
