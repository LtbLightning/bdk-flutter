import Flutter
import UIKit
public class SwiftBdkPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bdk_flutter",
                                       binaryMessenger: registrar.messenger(),
                                       codec: FlutterStandardMethodCodec.sharedInstance()
                                       )
    let instance = SwiftBdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
   public func dummyMethodToEnforceBundling() {
      dummy_method_to_enforce_bundling();
     }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        }
}

