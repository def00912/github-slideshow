# Quick Start Guide - AI Code Interpreter App

This guide will help you get the Flutter AI Code Interpreter app up and running quickly.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher) - [Installation Guide](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (3.0.0 or higher) - Comes with Flutter
- **Git** - For cloning the repository
- **Android Studio** or **VS Code** with Flutter extension
- **Xcode** (for iOS development on macOS)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/def00912/github-slideshow.git
cd github-slideshow
```

### 2. Install Dependencies

```bash
flutter pub get
```

This will download all the required packages defined in `pubspec.yaml`:
- dio (HTTP client)
- provider (state management)
- flutter_highlight (code highlighting)
- flutter_spinkit (loading indicators)

### 3. Verify Flutter Setup

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation. Fix any issues reported.

### 4. Run the App

#### For Android:

```bash
flutter run
```

Or specify the device:

```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

#### For iOS (macOS only):

```bash
cd ios
pod install  # Install iOS dependencies
cd ..
flutter run -d ios
```

#### For Web (Development):

```bash
flutter run -d chrome
```

### 5. Build for Production

#### Android APK:

```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle (for Play Store):

```bash
flutter build appbundle --release
```

#### iOS (macOS only):

```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode to archive and distribute.

## Quick Test

Once the app is running:

1. **Select a Language**: Choose from the dropdown (default is Python)
2. **Load Sample Code**: Click "Load Sample" to see example code
3. **Execute**: Click "Execute Code" to run the sample
4. **View Output**: See the execution result below the buttons

## App Features Overview

### Language Support
The app supports 11 programming languages:
- Python
- JavaScript
- Java
- C++
- Go
- Rust
- TypeScript
- PHP
- Ruby
- Swift
- Kotlin

### Main Components

1. **Language Selector**: Dropdown menu to choose programming language
2. **Code Editor**: Text area for entering code (supports 15 lines)
3. **Action Buttons**:
   - **Execute Code**: Runs the code (simulated in demo mode)
   - **Load Sample**: Loads pre-written example code
4. **Output Area**: Displays execution results or error messages

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/                            # Data models
│   ├── code_execution_request.dart
│   ├── code_execution_response.dart
│   └── programming_language.dart
├── providers/                         # State management
│   └── code_execution_provider.dart
├── screens/                           # UI screens
│   └── code_editor_screen.dart
└── services/                          # Business logic
    └── code_execution_service.dart

android/                               # Android-specific files
ios/                                   # iOS-specific files
test/                                  # Unit tests
```

## Current Mode: Demo/Simulation

The app currently runs in **demo mode** with simulated code execution. This allows you to:

- ✅ Test the UI and user experience
- ✅ Explore all supported programming languages
- ✅ See sample code for each language
- ✅ Understand the complete app flow

To enable **real code execution**, see the [Cloud Integration Guide](CLOUD_INTEGRATION.md).

## Troubleshooting

### Common Issues

**1. Dependencies not installing:**
```bash
flutter clean
flutter pub get
```

**2. Android build errors:**
- Check that Android SDK is installed
- Ensure `JAVA_HOME` is set correctly
- Try: `cd android && ./gradlew clean`

**3. iOS build errors:**
- Run: `cd ios && pod install && pod update`
- Check Xcode is up to date
- Verify iOS deployment target compatibility

**4. "No devices found":**
- For Android: Enable USB debugging on your device
- For iOS: Trust the computer on your device
- For Emulator: Start Android Emulator or iOS Simulator

### Getting Help

If you encounter issues:

1. Run `flutter doctor -v` for detailed diagnostics
2. Check the [Flutter documentation](https://docs.flutter.dev/)
3. Search [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
4. Open an issue on GitHub

## Development Tips

### Hot Reload

While the app is running, you can make changes to the code and see them instantly:

- Press `r` in the terminal to hot reload
- Press `R` to hot restart
- Press `q` to quit

### VS Code

If using VS Code:
1. Install the Flutter extension
2. Use F5 to run with debugging
3. Set breakpoints by clicking left of line numbers
4. View logs in the Debug Console

### Android Studio

If using Android Studio:
1. Open the project
2. Select device from toolbar
3. Click Run (green play button)
4. Use debugger and profiler tools

## Testing

Run unit tests:

```bash
flutter test
```

Run a specific test file:

```bash
flutter test test/widget_test.dart
```

## Code Quality

Check code quality:

```bash
flutter analyze
```

Format code:

```bash
flutter format lib/
```

## Next Steps

1. ✅ Complete this quick start
2. 📖 Read [FLUTTER_README.md](FLUTTER_README.md) for detailed documentation
3. 🔧 Review [CLOUD_INTEGRATION.md](CLOUD_INTEGRATION.md) for production setup
4. 🚀 Connect to a real cloud API for actual code execution
5. 📱 Deploy to App Store or Play Store

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Material Design 3](https://m3.material.io/)

## Support

For questions or issues:
- 📧 Open an issue on GitHub
- 💬 Check existing issues for solutions
- 📚 Review the documentation files

---

**Happy Coding! 🎉**
