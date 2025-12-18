# AI Code Interpreter - Flutter Mobile App

A cross-platform (Android & iOS) mobile application built with Flutter that interprets and executes code in any programming language using cloud-based AI training.

## Features

- 🚀 **Multi-Language Support**: Execute code in 11 programming languages
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

- 💡 **Smart Code Editor**: Clean, intuitive code input interface
- ⚡ **Real-time Execution**: Fast code interpretation and output display
- 📝 **Sample Code**: Pre-loaded examples for each language
- 🎨 **Material Design**: Modern, responsive UI following Material Design 3
- 🔄 **State Management**: Efficient state handling using Provider pattern
- 🌐 **Cloud-Ready**: Architecture prepared for cloud API integration
- ❗ **Error Handling**: Comprehensive error feedback and validation

## Architecture

### Project Structure

```
lib/
├── main.dart                           # Application entry point
├── models/                             # Data models
│   ├── code_execution_request.dart     # Request model
│   ├── code_execution_response.dart    # Response model
│   └── programming_language.dart       # Language enum
├── providers/                          # State management
│   └── code_execution_provider.dart    # Main provider
├── screens/                            # UI screens
│   └── code_editor_screen.dart         # Main editor screen
└── services/                           # Business logic
    └── code_execution_service.dart     # Code execution service
```

### Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **HTTP Client**: Dio
- **UI**: Material Design 3
- **Architecture**: Clean Architecture with Provider pattern

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/def00912/github-slideshow.git
   cd github-slideshow
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For Android:
   ```bash
   flutter run
   ```
   
   For iOS:
   ```bash
   flutter run -d ios
   ```
   
   For Web (testing):
   ```bash
   flutter run -d chrome
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## Cloud API Integration

The current implementation includes a simulated code execution service. To connect to a real cloud-based AI service:

1. **Update the API endpoint** in `lib/services/code_execution_service.dart`:
   ```dart
   static const String _baseUrl = 'YOUR_CLOUD_API_ENDPOINT';
   ```

2. **Configure your cloud service** (choose one):
   - Google Cloud AI Platform
   - AWS Lambda with API Gateway
   - Azure Functions
   - Custom backend server

3. **Update the `executeCode` method** to use the actual API:
   ```dart
   final response = await _dio.post(
     '/execute',
     data: request.toJson(),
   );
   return CodeExecutionResponse.fromJson(response.data);
   ```

4. **Add API authentication** if required:
   ```dart
   _dio.options.headers['Authorization'] = 'Bearer YOUR_API_KEY';
   ```

## Usage

1. **Select a Programming Language**: Choose from the dropdown menu
2. **Enter Code**: Type or paste your code in the editor
3. **Load Sample Code**: Click "Load Sample" to see example code
4. **Execute**: Press "Execute Code" to run your code
5. **View Output**: See results in the output panel below

## Demo Mode

The app currently runs in **demo mode** with simulated code execution. This allows you to:
- Test the UI and user experience
- Explore different programming languages
- See sample code for each language
- Understand the app flow without backend setup

To enable real code execution, follow the Cloud API Integration steps above.

## Configuration Files

### pubspec.yaml
Main configuration file containing:
- App metadata
- Dependencies (dio, provider, flutter_highlight, flutter_spinkit)
- Asset declarations

### Android Configuration
- `android/app/build.gradle`: Android build configuration
- `android/app/src/main/AndroidManifest.xml`: Android app manifest

### iOS Configuration
- `ios/Runner/Info.plist`: iOS app configuration

## Dependencies

```yaml
dependencies:
  flutter: sdk
  dio: ^5.4.0              # HTTP client
  provider: ^6.1.1          # State management
  flutter_highlight: ^0.7.0 # Code highlighting
  flutter_spinkit: ^5.2.0   # Loading indicators
  cupertino_icons: ^1.0.2   # iOS icons

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^3.0.0     # Linting rules
```

## Future Enhancements

- [ ] Real cloud API integration (Google Cloud AI, AWS, Azure)
- [ ] Code syntax highlighting in editor
- [ ] Code execution history
- [ ] Save/load code snippets
- [ ] Share code functionality
- [ ] Dark mode support
- [ ] Offline code analysis
- [ ] Multi-file project support
- [ ] Code debugging features
- [ ] Performance metrics and analytics

## Troubleshooting

### Common Issues

1. **Dependencies not installing**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Build errors on Android**
   - Check `android/app/build.gradle` for correct SDK versions
   - Ensure Java 8 or higher is installed

3. **Build errors on iOS**
   - Run `pod install` in the `ios` directory
   - Check Xcode version compatibility

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions, please open an issue on GitHub.

---

**Note**: This is a demonstration application. For production use, ensure proper security measures, API authentication, rate limiting, and error handling are implemented.
