#if os(iOS)
import Flutter
import UIKit
#elseif os(macOS)
import FlutterMacOS
#endif
public class BdkFlutterPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
#if os(iOS)
        let messenger = registrar.messenger()
#else
        let messenger = registrar.messenger
#endif
    let channel = FlutterMethodChannel(name: "bdk_flutter",
                                       binaryMessenger: messenger
                                       )
    let instance = BdkFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
}

