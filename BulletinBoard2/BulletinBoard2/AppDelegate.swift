//
//  AppDelegate.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (success, error) in
            if let error = error{
                NSLog("error requesting authorization for notifications: \(error)")
                return
            }
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PostController.shared.subscribeToPosts()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Error registering for remote notificaions: \(error)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PostController.shared.fetch()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        PostController.shared.resetBadgeCounter()
    }
    
    
}

