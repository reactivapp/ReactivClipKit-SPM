//
//  AnalyticsManager.swift
//  ReactivClipKit-SampleClip
//
//  Created by Reactiv Technologies Inc.
//

import Foundation
import ReactivClipKit

/// Demonstrates how to observe ReactivClipKit events and forward them to your analytics system.
///
/// Replace the `print` statements in each handler with calls to your analytics provider
/// (e.g., Firebase Analytics, Amplitude, Mixpanel).
class SampleAnalyticsManager {
    static let shared = SampleAnalyticsManager()
    private let publisher = ReactivClipEvents.publisher
    private var isObserving = false

    private init() {}

    // MARK: - Setup

    /// Starts listening for ReactivClipKit events. Call after `ReactivClipInitialize` completes.
    func setupEventObserving() {
        guard !isObserving else { return }

        publisher.on(.productViewed) { [weak self] event in
            guard let productData = event.productViewedData else { return }
            self?.handleProductViewed(productData)
        }

        publisher.on(.cartItemAdded) { [weak self] event in
            guard let cartData = event.cartItemAddedData else { return }
            self?.handleCartItemAdded(cartData)
        }

        publisher.on(.checkoutSuccess) { [weak self] event in
            guard let purchaseData = event.checkoutSuccessData else { return }
            self?.handleCheckoutSuccess(purchaseData)
        }

        publisher.on(.screenViewed) { [weak self] event in
            guard let screenData = event.screenViewedData else { return }
            self?.handleScreenViewed(screenData)
        }

        publisher.on(.notificationScheduled) { [weak self] event in
            guard let notificationData = event.notificationScheduledData else { return }
            self?.handleNotificationScheduled(notificationData)
        }

        publisher.on(.collectionViewed) { [weak self] event in
            guard let collectionData = event.collectionViewedData else { return }
            self?.handleCollectionViewed(collectionData)
        }

        // Multiple event types can share a single handler
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
    }

    func stopEventObserving() {
        publisher.removeAllHandlers()
        isObserving = false
    }

    // MARK: - Event Handlers

    private func handleProductViewed(_ data: ProductViewedData) {
        print("Analytics: Product Viewed — \(data.productTitle) (\(data.productId)), $\(data.productPrice)")

        // YourAnalytics.trackEvent("view_item", parameters: [
        //     "item_id": data.productId,
        //     "item_name": data.productTitle,
        //     "price": data.productPrice
        // ])
    }

    private func handleCollectionViewed(_ data: CollectionViewedData) {
        print("Analytics: Collection Viewed — \(data.collectionTitle) (\(data.collectionGid))")

        // YourAnalytics.trackEvent("view_collection", parameters: [...])
    }

    private func handleNotificationScheduled(_ data: NotificationScheduledData) {
        print("Analytics: Notification Scheduled — \(data.messageTitle) (\(data.messageId))")

        // YourAnalytics.trackEvent("notification_scheduled", parameters: [...])
    }

    private func handleCartItemAdded(_ data: CartItemAddedData) {
        print("Analytics: Cart Item Added — Cart \(data.cartId), $\(data.cartValue), \(data.items.count) items")

        for item in data.items {
            print("  → \(item.itemName) (\(item.itemVariant)): $\(item.itemPrice)")
        }

        // YourAnalytics.trackEvent("add_to_cart", parameters: [...])
    }

    private func handleCheckoutSuccess(_ data: CheckoutSuccessData) {
        print("Analytics: Purchase Completed — TX \(data.transactionId), $\(data.value), \(data.itemCount) items")

        // YourAnalytics.trackEvent("purchase", parameters: [...])
    }

    private func handleScreenViewed(_ data: ScreenViewedData) {
        print("Analytics: Screen Viewed — \(data.screenName) (\(data.screenClass))")

        if let previous = data.previousScreenName {
            print("  → Previous: \(previous)")
        }

        // YourAnalytics.trackScreenView(screenName: data.screenName)
    }

    private func handlePurchaseFlowEvent(_ event: ReactivClipEvent) {
        switch event.type {
        case .cartView:
            if let cartData = event.cartViewData {
                print("Analytics: Cart Viewed — \(cartData.cartId), $\(cartData.cartValue), \(cartData.itemCount) items")
            }

        case .checkoutStarted:
            if let checkoutData = event.checkoutStartedData {
                print("Analytics: Checkout Started — Cart \(checkoutData.cartId), $\(checkoutData.value)")
                if let coupon = checkoutData.couponCode {
                    print("  → Coupon: \(coupon)")
                }
            }

        case .checkoutFailed:
            print("Analytics: Checkout Failed")

        default:
            break
        }
    }
}
