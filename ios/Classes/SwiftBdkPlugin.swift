import Flutter
import UIKit

public class SwiftBdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bdk_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftBdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     guard let args = call.arguments as? [String:Any] else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
            return
        }
        switch (call.method) {
           case "getPlatformVersion":  result("iOS " + UIDevice.current.systemVersion)
          default :  result.notImplemented()
        }
  }
}
