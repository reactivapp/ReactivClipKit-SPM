# ReactivClipKit

A Swift package that brings Reactiv's rich commerce experiences to iOS App Clips.

> **📢 ReactivClipKit has two supported release lines:** use `2.x` for the latest features on Xcode 26+, or use `1.3.x` if you need v1 support for Xcode 16.

---

## ✨ Features

- Plug-and-play App Clip storefront powered by Reactiv
- Built-in analytics stream with typed events
- Single-store **and** multi-store initialization modes

---

## 📦 Installation (Swift Package Manager)

```swift
// Latest release line (Xcode 26+)
.dependencies = [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "2.0.0")
]
```

If you need v1 support for Xcode 16, pin the maintenance line instead:

```swift
.dependencies = [
    .package(url: "https://github.com/reactivapp/ReactivClipKit-SPM.git", from: "1.3.0")
]
```

Add the package in **Xcode → File → Add Packages…** and select the **ReactivClipKit** product for your App Clip target.

### Required dependency

```swift
.package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.0.0")
```

ReactivClipKit will initialise Sentry automatically if the SDK class is supplied.

---

## 🚀 Quick start

### 1 · Single-store initialization

```swift
try ReactivClipInitialize(
    appIdentifier: "your-reactiv-app-id",
    reactivEventsToken: "your-events-token",
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self
)
```

### 2 · Multi-store initialization

```swift
let stores: [StoreDescriptor] = [
    StoreDescriptor(uuid: "intl-uuid", storeURL: "https://domain.com",    eventsToken: "token-intl"),
    StoreDescriptor(uuid: "ca-uuid",   storeURL: "https://domain.com/ca", eventsToken: "token-ca"),
    StoreDescriptor(uuid: "au-uuid",   storeURL: "https://domain.com/au", eventsToken: "token-au"),
    StoreDescriptor(uuid: "gb-uuid",   storeURL: "https://domain.com/gb", eventsToken: "token-gb")
]

try ReactivClipInitializeMultiStore(
    stores: stores,
    appStoreID: "123456789",
    parentBundleIdentifier: "com.yourapp.bundle",
    sentrySDK: SentrySDK.self
)
```

The framework chooses the descriptor whose `storeURL` is the longest prefix of the invocation URL. If nothing matches, the first descriptor acts as a fallback.

### 3 · Launch the view

```swift
ReactivClipView()
```

---

## 📹 Video tutorial

Watch the end-to-end integration walk-through → **[ReactivClipKit Integration Tutorial](https://drive.google.com/file/d/1w1gd9TzY35dkec0mh_TIA53DD5iE66Dk/view?usp=sharing)**

---

## 🛠 Requirements

- iOS 16+
- **v1.3.x**: Xcode 16
- **v2.x**: Xcode 26+ (for Liquid Glass and iOS 26 features)

---

## 🚀 Version 2.x Migration

We're excited to announce that Reactiv ClipKit v2.x is now available! This release introduces major updates and paves the way for future innovation.

### **What's New**

- **Liquid Glass**: A sleek new design layer that enhances the look and feel of your App Clips
- **Xcode 26 Compatibility**: ClipKit v2.x has been updated to fully support Xcode 26 and iOS 26 features

### **Important Upgrade Notes**

- **Xcode 26 Required**: To use Reactiv ClipKit v2.x, you must update your Xcode projects to Xcode 26
- **Need Xcode 16 support?** Use the `1.3.x` maintenance line. Support for `1.3.x` will end in April 2026, aligned with Apple's expected cutoff for Xcode 16-based App Store submissions.
- **Want the latest features?** Use `2.x` on Xcode 26+

### **Migration Path**

To upgrade to v2.x:

1. Update to Xcode 26
2. Change your package dependency from `1.3.x` to `2.x`
3. Test your App Clip with the new Liquid Glass features

### **Recommendation**

To stay current with the latest features and security updates, we strongly recommend upgrading to Xcode 26 and adopting Reactiv ClipKit v2.x as soon as your development timeline allows.

---

## 📚 Documentation

Detailed guides live in the `Documentation` folder:

- [Usage](./Documentation/Usage.md)
- [API reference](./Documentation/API.md)
- [FAQ](./Documentation/FAQ.md)

### 🧪 Testing a Landing Page locally

If the Reactiv Dashboard is configured to send users to a landing page such as `pages/test`, you can test that flow locally by running your App Clip with an invocation URL.

In Xcode: **Edit Scheme…** → **Run** → **Arguments** → enable `_XCAppClipURL` and set it to a full URL like `https://<your-store-domain>/pages/test`.

See: [Usage → Testing a Landing Page Locally](./Documentation/Usage.md#testing-a-landing-page-locally)

---

## 🤝 Support

Need help? → support@reactivapp.com

---

## 🔒 License

ReactivClipKit is proprietary software. Contact Reactiv for licensing details.
