import Flutter
import UIKit
import AdSupport
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
      let controller = window?.rootViewController as! FlutterViewController
      
      let channel = FlutterMethodChannel(name: "native.advertising", binaryMessenger: controller.binaryMessenger)

              channel.setMethodCallHandler { call, result in

                  if call.method == "getAdvertisingInfo" {

                      self.handleAdvertising(result: result)
                  }
              }
      
      
      /// SAFELY read int values
      let nvAccountBrnadIDStr = Bundle.main.object(forInfoDictionaryKey: "nvBrandID") as? String
      let nvAccountBrnadIDInt = Int(nvAccountBrnadIDStr ?? "") ?? 0
      
      /// SAFELY read string values
      let nvAccountSecretKey = Bundle.main.object(forInfoDictionaryKey: "nvSecretKey") as? String ?? ""
      
      UNUserNotificationCenter.current().delegate = self
      NotifyvisitorsPlugin.initialize(withBrandId: nvAccountBrnadIDInt, secretKey: nvAccountSecretKey, launchingOptions: launchOptions)
      NotifyvisitorsPlugin.registerPush(withDelegate: self, app: application, launchOptions: launchOptions)
      
      // RNNotifyvisitors.initialize(withBrandId: nvAccountBrnadIDInt, secretKey: nvAccountSecretKey, launchingOptions: launchOptions)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func handleAdvertising(result: @escaping FlutterResult) {

        if #available(iOS 14, *) {
            let status =
                ATTrackingManager.trackingAuthorizationStatus
            if status == .notDetermined {
                ATTrackingManager.requestTrackingAuthorization {
                    newStatus in
                    self.sendAdvertisingInfo(
                        status: Int(newStatus.rawValue),
                        result: result
                    )
                }

            } else {

                sendAdvertisingInfo(
                    status: Int(status.rawValue),
                    result: result
                )
            }

        } else {
            let idfa = ASIdentifierManager
                .shared()
                .advertisingIdentifier
                .uuidString

            let trackingEnabled =
                ASIdentifierManager
                .shared()
                .isAdvertisingTrackingEnabled

            result([
                "advertisingId": idfa,
                "limitAdTracking": !trackingEnabled,
                "trackingStatus": "authorized"
            ])
        }
        
    }
    
    private func sendAdvertisingInfo(status: Int, result: @escaping FlutterResult) {

        let statusString: String

        switch status {

        case 3:
            statusString = "authorized"

        case 2:
            statusString = "denied"

        case 1:
            statusString = "restricted"

        case 0:
            statusString = "notDetermined"

        default:
            statusString = "unknown"
        }

        var advertisingId: String? = nil
        var limitAdTracking = true

        if status == 3 {

            advertisingId = ASIdentifierManager
                .shared()
                .advertisingIdentifier
                .uuidString

            limitAdTracking =
                !ASIdentifierManager
                .shared()
                .isAdvertisingTrackingEnabled
        }

        result([
            "advertisingId": advertisingId,
            "limitAdTracking": limitAdTracking,
            "trackingStatus": statusString
        ])
    }
    
//    private func sendAdvertisingInfo(status: ATTrackingManager.AuthorizationStatus, result: @escaping FlutterResult) {
//
//        let statusString: String
//
//        switch status {
//
//        case .authorized:
//            statusString = "authorized"
//
//        case .denied:
//            statusString = "denied"
//
//        case .restricted:
//            statusString = "restricted"
//
//        case .notDetermined:
//            statusString = "notDetermined"
//
//        @unknown default:
//            statusString = "unknown"
//        }
//
//        var advertisingId: String? = nil
//        var limitAdTracking = true
//
//        if status == .authorized {
//
//            advertisingId = ASIdentifierManager
//                .shared()
//                .advertisingIdentifier
//                .uuidString
//
//            limitAdTracking =
//                !ASIdentifierManager
//                .shared()
//                .isAdvertisingTrackingEnabled
//        }
//
//        result([
//            "advertisingId": advertisingId,
//            "limitAdTracking": limitAdTracking,
//            "trackingStatus": statusString
//        ])
//    }
    
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        NotifyvisitorsPlugin.applicationDidEnterBackground(application)
    }
    override func applicationWillEnterForeground(_ application: UIApplication) {
        NotifyvisitorsPlugin.applicationWillEnterForeground(application)
    }
    override func applicationDidBecomeActive(_ application: UIApplication) {
        NotifyvisitorsPlugin.applicationDidBecomeActive(application)
    }
    override func applicationWillTerminate(_ application: UIApplication) {
        NotifyvisitorsPlugin.applicationWillTerminate()
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NotifyvisitorsPlugin.openUrl(app, open: url)
        return super.application(app, open: url)
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotifyvisitorsPlugin.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NotifyvisitorsPlugin.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NotifyvisitorsPlugin.willPresent(notification, withCompletionHandler: completionHandler)
    }
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        NotifyvisitorsPlugin.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NotifyvisitorsPlugin.didReceive(response)
    }
}
