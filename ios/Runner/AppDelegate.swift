import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDoHn9fLrBIKZ3bJ8LdJ1e0pcqTlDWpYxU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
