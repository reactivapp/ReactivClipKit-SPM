//
//  ReactivClipKitSampleClipApp.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc. on 2025-04-21.
//

import ReactivClipKit
import SwiftUI

// MARK: - Mock Analytics Service

/// MockAnalytics
///
/// This class provides mock implementations of Firebase Analytics methods
/// for demonstration purposes without requiring Firebase package installation.
/// In a production environment, these would be replaced with actual Firebase SDK calls.
enum MockAnalytics {
    /// Provides a simulated asynchronous Firebase session ID
    ///
    /// - Parameter completion: Callback that receives the generated session ID or error
    static func sessionID(completion: @escaping (Int64, Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            let mockSessionID = Int64(Date().timeIntervalSince1970 * 1000)
            print("[MockAnalytics] Generated session ID: \(mockSessionID)")
            completion(mockSessionID, nil)
        }
    }
    
    /// Provides a simulated Firebase app instance ID
    ///
    /// - Returns: A closure that returns a mock app instance ID
    static var appInstanceID: () -> String? {
        return { "1234567890" } // Static mock ID for demonstration
    }
}

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
                ***REMOVED***, // Your app identifier from Reactiv dashboard
                ***REMOVED***, // Your Reactiv events token
                firebaseSessionIDProvider: MockAnalytics.sessionID, // Real Analytics.sessionID
                firebaseAppInstanceId: MockAnalytics.appInstanceID(), // Real Analytics.appInstanceID()
                appStoreID: "123456", // Your App Store ID
                parentBundleIdentifier: "com.yourapp.bundleid" // Your main app bundle ID
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
