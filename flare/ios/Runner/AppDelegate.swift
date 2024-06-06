import Flutter
import UIKit
import RadarSDK
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let dartDefinesString = Bundle.main.infoDictionary?["DART_DEFINES"] as? String {
      var dartDefinesDictionary = [String:String]()
      for definedValue in dartDefinesString.components(separatedBy: ",") {
        if let data = Data(base64Encoded: definedValue),
           let decoded = String(data: data, encoding: .utf8) {
          let values = decoded.components(separatedBy: "=")
          if values.count == 2 {
            dartDefinesDictionary[values[0]] = values[1]
          }
        }
      }
      
      if let googleMapsApiKey = dartDefinesDictionary["GOOGLE_MAPS_API_KEY"] {
        GMSServices.provideAPIKey(googleMapsApiKey)
      }
      
      if let radarPublishableKey = dartDefinesDictionary["RADAR_PK"] {
        Radar.initialize(publishableKey: radarPublishableKey)
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
