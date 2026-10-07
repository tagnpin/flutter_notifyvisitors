//
//  NotificationService.swift
//  notifyvisitorsServiceExtension
//
//  Created by Notifyvisitors Macbook Pro 001  on 07/10/26.
//

import UserNotifications
import notifyvisitorsNotificationService

class NotificationService: notifyvisitorsNotificationService {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
}
