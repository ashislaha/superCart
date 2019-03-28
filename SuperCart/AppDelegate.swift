//
//  AppDelegate.swift
//  SuperCart
//
//  Created by Ashis Laha on 3/23/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit
import ApiAI
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // firebase
        //FirebaseApp.configure()
        
        // initialise dialogflow
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "594cfd0d08084f15a90c9615da97fd90"
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
        
        IQKeyboardManager.shared.enable = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        AppManager.shared.userAgent["model"] = UIDevice.current.model
        AppManager.shared.userAgent["systemName"] = UIDevice.current.systemName
        AppManager.shared.userAgent["systemVersion"] = UIDevice.current.systemVersion
        
        // register notifications
        registerNotifications()
        
        return true
    }

    // MARK: push notifications handling
    
    private func registerNotifications() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound]
        userNotificationCenter.requestAuthorization(options: options) { (isGranted, error) in
            if !isGranted {
                print("something wrong in local notification permission")
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    // fetch the device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokens = deviceToken.map {
            return String(format: "%02.2hhx", $0)
        }
        let token = deviceTokens.joined()
        AppManager.shared.userAgent["deviceToken"] = token
        print("\n\ndevice token ",token, "\n\n")
    }
    
    // failed to fetch remote notificaion
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to fetch device tokens", error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("receive remote notification", userInfo)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// MARK: UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound]) // play sound and show alert to the user
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("perform some Dismiss action handler")
        case UNNotificationDefaultActionIdentifier:
            print("perform some default action handler here")
        default:
            print("default action handler of local notification")
        }
    }
}

