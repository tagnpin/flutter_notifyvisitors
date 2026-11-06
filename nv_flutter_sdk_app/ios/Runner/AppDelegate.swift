import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

    
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      var nvMode:String? = nil

       #if DEBUG
           nvMode = "debug"
       #else
           nvMode = "live"
      #endif
      
      
      /// SAFELY read int values
      let nvAccountBrnadIDStr = Bundle.main.object(forInfoDictionaryKey: "nvBrandID") as? String
      let nvAccountBrnadIDInt = Int(nvAccountBrnadIDStr ?? "") ?? 0
      
      /// SAFELY read string values
      let nvAccountSecretKey = Bundle.main.object(forInfoDictionaryKey: "nvSecretKey") as? String ?? ""
      let config = NVConfiguration()
      config.brandID = nvAccountBrnadIDInt
      config.secretKey = nvAccountSecretKey
      config.appMode = nvMode
      
      UNUserNotificationCenter.current().delegate = self
     // NotifyvisitorsPlugin.
      //NotifyvisitorsPlugin
    //  NotifyvisitorsPlugin.initialize(withBrandId: nvAccountBrnadIDInt, secretKey: nvAccountSecretKey, launchingOptions: launchOptions)
      NotifyvisitorsPlugin.nvRegister(withConfiguration: config)
      NotifyvisitorsPlugin.registerPush(withDelegate: self, app: application, launchOptions: launchOptions)
      
      //GeneratedPluginRegistrant.register(with: self)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        
           GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
       }
    
//    override func applicationDidEnterBackground(_ application: UIApplication) {
//        print("[Flutter]-[AppDelegate]: applicationDidEnterBackground")
//      //  NotifyvisitorsPlugin.applicationDidEnterBackground(application)
//    }
    
//    override func applicationWillEnterForeground(_ application: UIApplication) {
//        print("[Flutter]-[AppDelegate]: applicationWillEnterForeground")
//       // NotifyvisitorsPlugin.applicationWillEnterForeground(application)
//    }
    
//    override func applicationDidBecomeActive(_ application: UIApplication) {
//        print("[Flutter]-[AppDelegate]: applicationDidBecomeActive")
//       // NotifyvisitorsPlugin.applicationDidBecomeActive(application)
//    }
    
//    override func applicationWillTerminate(_ application: UIApplication) {
//        print("[Flutter]-[AppDelegate]: applicationWillTerminate")
//        
//        NotifyvisitorsPlugin.applicationWillTerminate()
//    }
    
//    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("[Flutter]-[AppDelegate]: application open url")
//        //NotifyvisitorsPlugin.openUrl(app, open: url)
//        return super.application(app, open: url)
//    }
    
//    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print("[Flutter]-[AppDelegate]: didRegisterForRemoteNotificationsWithDeviceToken")
//        //NotifyvisitorsPlugin.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//    }
    
//    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("[Flutter]-[AppDelegate]: didFailToRegisterForRemoteNotificationsWithError")
//       // NotifyvisitorsPlugin.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
//    }
    
//    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("[Flutter]-[AppDelegate]: willPresent:Notification")
//       // NotifyvisitorsPlugin.willPresent(notification, withCompletionHandler: completionHandler)
//    }
    
//    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print("[Flutter]-[AppDelegate]: didReceiveRemoteNotification:fetchCompletionHandler")
//       // NotifyvisitorsPlugin.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
//    }
    
//    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("[Flutter]-[AppDelegate]: didReceive:UNNotificationResponse")
//      //  NotifyvisitorsPlugin.didReceive(response)
//    }
    
}
