//
//  ReactivClipKitSampleClipApp.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc. on 2025-04-21.
//

import ReactivClipKit
import SwiftUI

// MARK: - App Entry Point

/// ReactivClipKitSampleClipApp
///
/// Main entry point for the App Clip demonstration of ReactivClipKit.
/// This sample shows how to properly initialize and configure the ReactivClipKit
/// SDK within an App Clip context.
@main
struct ReactivClipKitSampleClipApp: App {
    // MARK: - Properties
    
    /// Application delegate for handling Firebase initialization and notifications
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - Initialization
    
    /// Initializes the App Clip and configures ReactivClipKit
    init() {
        configureReactivClipKit()
        setupAnalytics()
    }
    
    // MARK: - Scene Configuration
    
    var body: some Scene {
        WindowGroup {
            ReactivClipView()
        }
    }
    
    // MARK: - Private Methods
    
    /// Configures the ReactivClipKit SDK with required parameters
    private func configureReactivClipKit() {
        do {
            try ReactivClipInitialize(
                appIdentifier: "", // Your app identifier from Reactiv dashboard
                reactivEventsToken: "", // Your Reactiv events token
                appStoreID: "", // Your App Store ID
                parentBundleIdentifier: "com.yourapp.bundleid",
                sentrySDK: nil // Pass SentrySDK.self from the Sentry framework
            )
            print("[ReactivClipKitSampleClipApp] ReactivClipKit initialized successfully")
        } catch {
            print("[ERROR] Failed to initialize ReactivClipKit: \(error)")
        }
    }
    
    /// Sets up event tracking for analytics
    private func setupAnalytics() {
        // Wait a moment to ensure ReactivClipKit is fully initialized
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Set up event tracking with our analytics manager
            SampleAnalyticsManager.shared.setupEventObserving()
            
            print("[ReactivClipKitSampleClipApp] Analytics setup complete")
            print("")
            print("🔍 Events will now be logged when they occur:")
            print("- When a product is viewed")
            print("- When items are added to cart")
            print("- When checkout completes")
            print("- When screens are viewed")
            print("- And other purchase flow events")
            print("")
        }
    }
}
