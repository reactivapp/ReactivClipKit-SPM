//
//  ReactivClipKitSampleClipApp.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc. on 2025-04-21.
//

import ReactivClipKit
import SwiftUI

/// Main entry point for the App Clip. Initializes ReactivClipKit and sets up analytics event observation.
@main
struct ReactivClipKitSampleClipApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        configureReactivClipKit()
        setupAnalytics()
    }

    var body: some Scene {
        WindowGroup {
            ReactivClipView()
        }
    }

    // MARK: - Private Methods

    private func configureReactivClipKit() {
        do {
            // Multi-store initialization example:
            //
            // let stores: [StoreDescriptor] = [
            //     StoreDescriptor(uuid: "intl-uuid", storeURL: "https://domain.com",    eventsToken: "token-intl"),
            //     StoreDescriptor(uuid: "ca-uuid",   storeURL: "https://domain.com/ca", eventsToken: "token-ca"),
            //     StoreDescriptor(uuid: "au-uuid",   storeURL: "https://domain.com/au", eventsToken: "token-au"),
            //     StoreDescriptor(uuid: "gb-uuid",   storeURL: "https://domain.com/gb", eventsToken: "token-gb")
            // ]
            //
            // try ReactivClipInitializeMultiStore(
            //     stores: stores,
            //     appStoreID: "",
            //     parentBundleIdentifier: "com.yourapp.bundleid",
            //     sentrySDK: nil
            // )

            try ReactivClipInitialize(
                appIdentifier: "",              // Your app identifier from Reactiv dashboard
                reactivEventsToken: "",          // Your Reactiv events token
                appStoreID: "",                  // Your App Store ID
                parentBundleIdentifier: "com.yourapp.bundleid",
                sentrySDK: nil                   // Pass SentrySDK.self from the Sentry framework
            )
        } catch {
            print("[ReactivClipKit] Initialization failed: \(error)")
        }
    }

    /// Waits for ReactivClipKit to finish initializing, then starts event observation.
    private func setupAnalytics() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            SampleAnalyticsManager.shared.setupEventObserving()
        }
    }
}
