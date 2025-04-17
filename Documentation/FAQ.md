# ReactivClipKit FAQ

## Dependencies

**Q: Do I need to install Sentry?**  
A: Yes. Sentry is required for error tracking. Add the Sentry package to your App Clip target, but you don't need to initialize it - ReactivClipKit handles this automatically.

**Q: Do I need to install Firebase?**  
A: Yes. Firebase is required for analytics. Follow the [official Firebase iOS SDK setup guide](https://firebase.google.com/docs/ios/setup) and pass the session information during ReactivClipKit initialization.


## Initialization

**Q: What's the right way to initialize ReactivClipKit?**  
A: Initialize ReactivClipKit in your SwiftUI App's `init` method using `try ReactivClipInitialize()` within a try-catch block, after Firebase has been configured.

**Q: What happens if initialization fails?**  
A: The framework will throw a `ReactivClipInitError` with specific information about what went wrong.

**Q: Can I initialize the framework multiple times?**  
A: No. Subsequent initialization attempts will throw a `multipleInitialization` error.

## Features

**Q: Do I need to initialize Sentry or other error tracking?**  
A: No. ReactivClipKit handles error tracking internally. You only need to install the Sentry package.

**Q: What's the minimum required setup?**  
A: Valid `appIdentifier`, `reactivEventsToken`, `appStoreID`, and `parentBundleIdentifier`, plus the Firebase and Sentry packages installed in your target. You also need to provide `firebaseSessionIDProvider` and `firebaseAppInstanceId`.

**Q: How to customize the UI?**  
A: UI customization is managed through the Reactiv Dashboard.

## Troubleshooting

**Q: Why am I getting "Framework already initialized" warnings?**  
A: You're likely attempting to initialize the framework multiple times. Check your app lifecycle and ensure you're only initializing once in your App's `init`.

**Q: Why isn't my App Clip showing any content?**  
A: Verify your App ID and tokens are correct, check for initialization errors in your logs, and ensure Firebase was configured before ReactivClipKit initialization.

**Q: How do I debug initialization issues?**  
A: Use proper error handling with try-catch and log any errors from initialization. Look for specific error types like `missingAppIdentifier` to pinpoint the issue.

**Q: How can I check if initialization was successful?**  
A: Call `ReactivClipIsInitialized()` which returns a boolean indicating status.

**Q: My app crashes with Sentry-related errors. What should I do?**  
A: Make sure you've added the Sentry package to your App Clip target. No initialization is required, but the package must be included.

**Q: Do I need to initialize Firebase before ReactivClipKit?**  
A: Yes. Firebase must be configured in your AppDelegate before initializing ReactivClipKit in your App's `init` method.

---

For additional support, contact us at support@reactivapp.com 