//
//  AppDelegate.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc. on 2025-04-21.
//

// MARK: - Imports

//
import ReactivClipKit
import UIKit
import UserNotifications

// MARK: - App Delegate

/// AppDelegate for ReactivClipKit Sample App Clip
///
/// Handles application lifecycle events and push notification handling.
/// This demonstrates how to properly set up an AppDelegate for use with ReactivClipKit,
/// including the necessary notification handling for analytics tracking.
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: - Application Lifecycle
    
    /// Called when the application has finished launching
    ///
    /// - Parameters:
    ///   - application: The singleton app object
    ///   - launchOptions: A dictionary indicating the reason the app was launched
    /// - Returns: `true` if the app can handle the launch options
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set up notification handling
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: - Notification Handling
    
    /// Handles user interaction with a notification
    ///
    /// - Parameters:
    ///   - center: The notification center object
    ///   - response: The user's response to the notification
    ///   - completionHandler: The block to execute when you're done processing the notification
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // Notify ReactivClipKit about the notification interaction for analytics tracking
        NotificationCenter.default.postNotificationTapped(response: response)
        completionHandler()
    }
}
