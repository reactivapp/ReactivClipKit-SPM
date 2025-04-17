# ReactivClipKit Documentation

Welcome to the ReactivClipKit documentation. This guide will help you integrate and use the ReactivClipKit framework in your iOS App Clip.

## Contents

- [Getting Started](#getting-started)
- [Required Dependencies](#required-dependencies)
- [Integration Details](#integration-details)
- [API Reference](#api-reference)
- [Common Questions](#common-questions)
- [Support](#support)

## Getting Started

ReactivClipKit makes it easy to create rich, dynamic App Clip experiences. Follow these steps to integrate the framework:

1. **Install ReactivClipKit**: Add the package using Swift Package Manager
2. **Install Dependencies**: Add required Sentry package and Firebase SDK
3. **Configure Firebase**: Create an AppDelegate to configure Firebase
4. **Initialize ReactivClipKit**: Call `try ReactivClipInitialize(...)` in your SwiftUI App's `init` method
5. **Display**: Use `ReactivClipView()` as your root view

For detailed instructions, see the [Usage Guide](./Usage.md).

## Required Dependencies

### Sentry
ReactivClipKit requires the Sentry package for error tracking:
- Add the Sentry package to your App Clip target
- No manual initialization required

### Firebase
ReactivClipKit requires Firebase for analytics:
- Follow the [official Firebase setup guide](https://firebase.google.com/docs/ios/setup)
- Configure Firebase in your AppDelegate
- Pass Firebase session info during ReactivClipKit initialization

## Integration Details

ReactivClipKit integrates with:

- Firebase (required) - for analytics and tracking
- Sentry (required) - for error tracking
- App Store Connect - for app distribution

### Best Practices

- Configure Firebase in the AppDelegate
- Initialize ReactivClipKit in the SwiftUI App's `init` method, not in AppDelegate
- Use proper error handling with try-catch blocks
- Ensure Sentry package is added to your App Clip target
- Always check initialization status with `ReactivClipIsInitialized()`

## API Reference

For detailed information about the available APIs, see the [API Reference](./API.md).

## Common Questions

See our [FAQ](./FAQ.md) for answers to common questions and troubleshooting tips.

## Support

For support inquiries, contact us at support@reactivapp.com 