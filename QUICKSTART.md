# Quick Start Guide

## Prerequisites

- Flutter SDK 3.0.0 or later
- Dart 3.0.0 or later
- Android Studio or VS Code with Flutter extension

## Setup & Run

### 1. Get Dependencies
```bash
cd d:\Flutter_app
flutter pub get
```

### 2. Run the App

**For Android:**
```bash
flutter run
```

**For iOS (macOS only):**
```bash
flutter run -d ios
```

**For Web:**
```bash
flutter run -d web
```

### 3. Run Unit Tests
```bash
flutter test
```

## File Structure Reference

```
lib/
├── main.dart                          # App entry point with ProviderScope
├── app.dart                          # MaterialApp wrapper
├── theme/
│   └── app_theme.dart               # Theme colors & typography
└── features/calculator/
    ├── provider/
    │   ├── calculator_provider.dart  # Riverpod StateNotifierProvider
    │   ├── calculator_notifier.dart  # Business logic & state management
    │   └── calculator_state.dart     # Immutable state class
    ├── logic/
    │   ├── expression_evaluator.dart # Math expression parsing
    │   └── number_formatter.dart     # Number formatting (scientific notation)
    ├── widgets/
    │   ├── calculator_display.dart   # Display panel with animations
    │   ├── calc_button.dart          # Individual button with scale animation
    │   └── button_grid.dart          # 5×4 button grid layout
    └── calculator_page.dart          # Main calculator page

test/
└── calculator_notifier_test.dart     # 14+ unit tests

Configuration:
├── pubspec.yaml                      # Dependencies & project config
├── analysis_options.yaml             # Linting rules
├── .gitignore                        # Git ignore file
├── README.md                         # Full documentation
└── IMPLEMENTATION_SUMMARY.md         # Implementation checklist
```

## Key Features

### Calculator Operations
- Basic arithmetic: +, −, ×, ÷
- Percentage: %
- Sign toggle: +/−
- Decimal: .
- Backspace with long-press
- AC/C with dynamic label

### Advanced Features
- **Order of Operations**: Correctly evaluates expressions using math_expressions
- **Error Handling**: Division by zero, invalid expressions
- **Scientific Notation**: Automatic for numbers > 12 digits
- **Negative Numbers**: Supports "5 × −3" syntax
- **Decimal Precision**: Handles floating-point arithmetic

### UI/UX
- Modern dark theme (iOS-like)
- Smooth animations on all interactions
- Haptic feedback on button press
- Responsive layout for all screen sizes
- Accessibility features for screen readers

### State Management
- Riverpod with StateNotifier
- Immutable state with copyWith
- Efficient rebuilds only when needed

## Testing

Run all tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/calculator_notifier_test.dart
```

Run with coverage:
```bash
flutter test --coverage
```

## Building for Production

### Android Release
```bash
flutter build apk --release
```

### iOS Release (macOS only)
```bash
flutter build ios --release
```

### Web Release
```bash
flutter build web --release
```

## Troubleshooting

### "Pub get" fails
```bash
flutter clean
flutter pub get
```

### Build issues on Android
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter run
```

### Hot reload not working
- Try hot restart: press 'R' in terminal
- Or rebuild: `flutter run`

## Documentation

- **Full README**: See `README.md` for complete documentation
- **Implementation Details**: See `IMPLEMENTATION_SUMMARY.md`
- **Code Comments**: Check source files for inline documentation

## Customization

### Change Theme Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color background = Color(0xFF0D0D0F); // Modify hex values
```

### Modify Button Styling
Edit `lib/features/calculator/widgets/calc_button.dart`:
```dart
borderRadius: BorderRadius.circular(16), // Change corner radius
```

### Adjust Animation Timing
Edit `lib/features/calculator/calculator_page.dart`:
```dart
duration: const Duration(milliseconds: 300), // Change duration
```

## Performance Notes

- Uses `RepaintBoundary` around button grid to prevent unnecessary repaints
- Animations use `AnimationController` with proper disposal
- State updates are efficient with Riverpod's selective rebuilds
- Numbers are formatted lazily only when displayed

## Known Limitations

- No scientific functions (as per requirements)
- No history of calculations
- No multi-line expressions
- No custom precision settings

## Support

For issues or questions:
1. Check the README.md
2. Review test cases in `test/calculator_notifier_test.dart`
3. Check inline comments in source files
