import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      if let googleMapsApiKey = Bundle.main.infoDictionary?["LT_MAPS_API_KEY"] as? String {
          GMSServices.provideAPIKey(googleMapsApiKey)
      } else {
          print("Google Maps API key not found")
      }
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
