//
//  AppDelegate.swift
//  ReactivClipKit-Sample
//
//  Created by Reactiv Technologies Inc.
//

import ReactivClipKit
import UIKit
import UserNotifications

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        // Your app already requests notification permission and registers for remote
        // notifications somewhere — keep that setup. ReactivClipKit relies on the token
        // your existing flow obtains; it does not call requestAuthorization itself.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }

        return true
    }

    // Forward the APNs device token so ReactivClipKit can register it with Reactiv's push API.
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        NotificationCenter.default.postDeviceTokenReceived(deviceToken: deviceToken)
    }

    // Forward notification taps. ReactivClipKit handles Reactiv-owned pushes; the closure
    // runs for everything else so your app can handle its own push types.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        NotificationCenter.default.handleReactivNotificationTap(response: response) {
            // Not a Reactiv push — your app's own routing runs here.
            // Leave empty if your app has no other push types.
        }
        completionHandler()
    }

    // MARK: - Defensive Universal Link forwarding
    //
    // Many third-party SDKs (Branch, OneSignal, Firebase Dynamic Links, Klaviyo, etc.)
    // method-swizzle `application(_:continue:)` and consume incoming Universal Links
    // before SwiftUI's `.onContinueUserActivity` (inside `ReactivClipHost`) can fire.
    //
    // To guarantee Reactiv-owned URLs reach ClipKit regardless of what other SDKs are
    // doing, explicitly forward `appclip.apple.com` URLs from the AppDelegate. Returning
    // `true` after forwarding tells iOS the activity was handled and stops other
    // handlers from also processing it.
    //
    // Apps without third-party URL-handling SDKs can omit this — `ReactivClipHost`'s
    // SwiftUI modifier handles the URL on its own.
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        if let url = userActivity.webpageURL,
           url.host?.lowercased() == "appclip.apple.com" {
            NotificationCenter.default.forwardInvocationURL(url)
            return true
        }
        return false
    }
}
