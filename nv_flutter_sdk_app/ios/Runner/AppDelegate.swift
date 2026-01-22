import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
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
