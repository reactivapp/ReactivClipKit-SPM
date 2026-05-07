//
//  ReactivClipSampleApp.swift
//  ReactivClipKit-Sample
//
//  Created by Reactiv Technologies Inc.
//

import ReactivClipKit
import SwiftUI

@main
struct ReactivClipSampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        do {
            try ReactivClipInitialize(
                appIdentifier: "",                              // Your app identifier from Reactiv dashboard
                reactivEventsToken: "",                          // Your Reactiv events token
                appStoreID: "",                                  // Your App Store ID
                parentBundleIdentifier: "com.yourapp.bundleid",  // Your host app's own bundle ID
                initializationOptions: [
                    "REACTIV_FULL_APP_MODE": true
                ]
            )
        } catch {
            print("[ReactivClipKit] Initialization failed: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ReactivClipHost {
                ContentView()
            }
        }
    }
}
