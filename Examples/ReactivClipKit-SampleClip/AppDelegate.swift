//
//  AppDelegate.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc. on 2025-04-21.
//

import ReactivClipKit
import UIKit
import UserNotifications

/// Handles push notification registration and forwarding for ReactivClipKit.
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        return true
    }

    // MARK: - Push Token Forwarding

    /// Required for remote notifications: forwards APNs device token to ReactivClipKit.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationCenter.default.postDeviceTokenReceived(deviceToken: deviceToken)
    }

    // MARK: - Notification Handling

    /// Forwards notification taps to ReactivClipKit for analytics tracking and deep link handling.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        NotificationCenter.default.postNotificationTapped(response: response)
        completionHandler()
    }
}
