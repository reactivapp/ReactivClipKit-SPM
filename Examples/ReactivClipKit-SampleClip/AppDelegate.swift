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

    /// Forwards the APNs device token to ReactivClipKit. Required for push notification delivery.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Available in a future release:
        // NotificationCenter.default.postDeviceTokenReceived(deviceToken: deviceToken)
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
