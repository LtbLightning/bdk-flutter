import Flutter
import UIKit
public class BdkFlutterPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bdk_flutter",
                                       binaryMessenger: registrar.messenger(),
                                       codec: FlutterStandardMethodCodec.sharedInstance()
                                       )
    let instance = BdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
   public func dummyMethodToEnforceBundling() {
       let dummy = dummy_method_to_enforce_bundling()
        print(dummy)
     }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        }
}

