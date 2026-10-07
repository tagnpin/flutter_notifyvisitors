//
//  notifyvisitorsNotificationService.h
//  notifyvisitorsNotificationService
//
//  Created by Notifyvisitors Macbook Air 4 on 27/02/24.
//

#import <UserNotifications/UserNotifications.h>
#import <Foundation/Foundation.h>

//! Project version number for notifyvisitorsNotificationService.
FOUNDATION_EXPORT double notifyvisitorsNotificationServiceVersionNumber;

//! Project version string for notifyvisitorsNotificationService.
FOUNDATION_EXPORT const unsigned char notifyvisitorsNotificationServiceVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <notifyvisitorsNotificationService/PublicHeader.h>




@interface notifyvisitorsNotificationService : UNNotificationServiceExtension

+(void)didReceiveNotificationRequest:(UNNotificationRequest *_Nullable)request withBestAttemptContent:(UNMutableNotificationContent*_Nullable)bestAttemptContent withContentHandler:(void (^_Nullable)(UNNotificationContent * _Nonnull))contentHandler;


+(void)serviceExtensionTimeWillExpire;
@end

