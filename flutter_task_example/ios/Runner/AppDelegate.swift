import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let channel = FlutterMethodChannel(name: "com.example.flutter_task_example/methods", binaryMessenger: controller.binaryMessenger)
          channel.setMethodCallHandler({
              [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
              if call.method == "enableBluetooth" {
                  self?.enableBluetooth(result: result)
              } else {
                  result(FlutterMethodNotImplemented)
              }
          })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

private func enableBluetooth(result: FlutterResult) {
        // Add your code here to enable Bluetooth on iOS
        // Ensure that you have appropriate usage descriptions for Bluetooth in your Info.plist
        // For example, you can use CoreBluetooth framework to enable Bluetooth
        // Refer to Apple's CoreBluetooth documentation for implementation details
        result(true) // Assume Bluetooth enabling succeeded
    }