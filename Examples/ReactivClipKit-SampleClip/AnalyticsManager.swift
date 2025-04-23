//
//  AnalyticsManager.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc.
//

import Foundation
import ReactivClipKit

// MARK: - Sample Analytics Manager

/// This class demonstrates how to integrate ReactivClipKit events with your analytics system.
///
/// Use this as a reference for implementing your own analytics integration. The class shows:
/// - Setting up event observers
/// - Handling typed event data
/// - Converting events to analytics calls
/// - Processing different event types
class SampleAnalyticsManager {
    // MARK: - Properties
    
    /// Singleton instance
    static let shared = SampleAnalyticsManager()
    private let publisher = ReactivClipEvents.publisher

    /// Flag indicating if event observing is active
    private var isObserving = false
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Sets up event observation from ReactivClipKit
    ///
    /// Call this method after ReactivClipKit is initialized to begin receiving events
    func setupEventObserving() {
        guard !isObserving else { return }
        
        // Get the shared event publisher through the public interface
        
        // MARK: Product Events

        publisher.on(.productViewed) { [weak self] event in
            // Access strongly-typed product data with convenience property
            guard let productData = event.productViewedData else { return }
            self?.handleProductViewed(productData)
        }
        
        // MARK: Cart Events

        publisher.on(.cartItemAdded) { [weak self] event in
            // Access strongly-typed cart data
            guard let cartData = event.cartItemAddedData else { return }
            self?.handleCartItemAdded(cartData)
        }
        
        // MARK: Checkout Events

        publisher.on(.checkoutSuccess) { [weak self] event in
            // Access strongly-typed checkout data
            guard let purchaseData = event.checkoutSuccessData else { return }
            self?.handleCheckoutSuccess(purchaseData)
        }
        
        // MARK: Screen Events

        publisher.on(.screenViewed) { [weak self] event in
            // Access strongly-typed screen data
            guard let screenData = event.screenViewedData else { return }
            self?.handleScreenViewed(screenData)
        }
        
        // MARK: Multiple Event Types

        // For capturing multiple event types in one handler
        let purchaseFlowEvents: [ReactivClipEventType] = [
            .cartView,
            .checkoutStarted,
            .checkoutFailed
        ]
        
        for eventType in purchaseFlowEvents {
            publisher.on(eventType) { [weak self] event in
                self?.handlePurchaseFlowEvent(event)
            }
        }
        
        isObserving = true
        print("[SampleAnalyticsManager] Event observation enabled")
    }
    
    /// Stops all event observation
    func stopEventObserving() {
        publisher.removeAllHandlers()
        isObserving = false
        print("[SampleAnalyticsManager] Event observation disabled")
    }
    
    // MARK: - Event Handlers
    
    /// Handles product viewed events
    private func handleProductViewed(_ data: ProductViewedData) {
        print("📊 Analytics: Product Viewed")
        print("  - Product: \(data.productTitle)")
        print("  - ID: \(data.productId)")
        print("  - Price: $\(data.productPrice)")
        
        // In a real implementation, you would send this data to your analytics system:
        // YourAnalytics.trackEvent("view_item", parameters: [
        //     "item_id": data.productId,
        //     "item_name": data.productTitle,
        //     "price": data.productPrice
        // ])
    }
    
    /// Handles cart item added events
    private func handleCartItemAdded(_ data: CartItemAddedData) {
        print("📊 Analytics: Cart Item Added")
        print("  - Cart ID: \(data.cartId)")
        print("  - Cart Value: $\(data.cartValue)")
        print("  - Items: \(data.items.count)")
        
        // Log each item
        for item in data.items {
            print("    - \(item.itemName) (\(item.itemVariant)): $\(item.itemPrice)")
        }
        
        // In a real implementation:
        // YourAnalytics.trackEvent("add_to_cart", parameters: [...])
    }
    
    /// Handles checkout success events
    private func handleCheckoutSuccess(_ data: CheckoutSuccessData) {
        print("📊 Analytics: Purchase Completed")
        print("  - Transaction ID: \(data.transactionId)")
        print("  - Value: $\(data.value)")
        print("  - Item Count: \(data.itemCount)")
        
        // In a real implementation:
        // YourAnalytics.trackEvent("purchase", parameters: [...])
    }
    
    /// Handles screen view events
    private func handleScreenViewed(_ data: ScreenViewedData) {
        print("📊 Analytics: Screen Viewed")
        print("  - Screen: \(data.screenName)")
        print("  - Class: \(data.screenClass)")
        
        if let previous = data.previousScreenName {
            print("  - Previous: \(previous)")
        }
        
        // In a real implementation:
        // YourAnalytics.trackScreenView(screenName: data.screenName)
    }
    
    /// Handles various purchase flow events
    private func handlePurchaseFlowEvent(_ event: ReactivClipEvent) {
        print("📊 Analytics: Purchase Flow Event - \(event.type.rawValue)")
        
        switch event.type {
        case .cartView:
            if let cartData = event.cartViewData {
                print("  - Cart Viewed: \(cartData.cartId)")
                print("  - Value: $\(cartData.cartValue)")
                print("  - Items: \(cartData.itemCount)")
            }
            
        case .checkoutStarted:
            if let checkoutData = event.checkoutStartedData {
                print("  - Checkout Started for Cart: \(checkoutData.cartId)")
                print("  - Value: $\(checkoutData.value)")
                if let coupon = checkoutData.couponCode {
                    print("  - Coupon: \(coupon)")
                }
            }
            
        case .checkoutFailed:
            // Handle checkout failed events
            print("  - Checkout Failed")
            
        default:
            break
        }
    }
}
