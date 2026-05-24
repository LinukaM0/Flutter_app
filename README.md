# Calculator App

A production-ready Flutter calculator app built with Riverpod state management and featuring a clean, modern dark theme.

## Features

- **Modern Dark UI**: Material Design 3 with custom dark theme (background #0D0D0F)
- **State Management**: Built with Riverpod's StateNotifier for predictable state management
- **Gesture & Animations**:
  - Button scale animation on press (80ms)
  - Shake animation for invalid backspace
  - Result scale animation on equals
  - Staggered launch animations
  - Haptic feedback on every button interaction
- **Complete Calculator Logic**:
  - Basic operations: +, −, ×, ÷
  - Percentage calculation
  - Toggle sign (+/−)
  - Decimal point support
  - Backspace with long-press support (AC/C)
  - Error handling for division by zero
- **Expression Evaluator**: Uses `math_expressions` for safe evaluation
- **Accessibility**:
  - Semantic labels on all buttons
  - Live region for screen reader announcements
  - Minimum 48×48 tap targets
- **Responsive Layout**:
  - 5×4 button grid with custom spanning for 0 button
  - Display panel with expression and result rows
  - Proper fading and scaling on all UI elements

## Getting Started

### Prerequisites
- Flutter 3.0+ (with Dart 3.0+)
- Xcode (for iOS) or Android Studio (for Android)

### Installation

1. Clone or open this repository:
   ```bash
   cd flutter_app
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

Tests cover:
- Basic arithmetic (3 + 5 = 8, 10 ÷ 4 = 2.5, 100 × 0 = 0)
- Division by zero error handling
- Percentage calculations
- Sign toggle
- Backspace functionality
- Double operator handling
- Decimal point edge cases
- Complex expressions with order of operations
- Clear and partial clear operations

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── app.dart                           # App widget wrapper
├── theme/
│   └── app_theme.dart               # Colors, typography, theme configuration
└── features/
    └── calculator/
        ├── provider/
        │   ├── calculator_provider.dart    # Riverpod StateNotifierProvider
        │   ├── calculator_notifier.dart    # Calculator business logic
        │   └── calculator_state.dart       # Immutable state class
        ├── logic/
        │   ├── expression_evaluator.dart   # Math expression parsing & evaluation
        │   └── number_formatter.dart       # Number formatting (scientific notation, decimals)
        ├── widgets/
        │   ├── calculator_display.dart     # Display panel with expression & result
        │   ├── calc_button.dart           # Animated calculator button widget
        │   └── button_grid.dart           # 5×4 button grid layout
        └── calculator_page.dart           # Main calculator page

test/
└── calculator_notifier_test.dart      # Comprehensive unit tests
```

## Design Specifications

### Colors
- **Background**: #0D0D0F (very dark gray/black)
- **Button Surface**: #1C1C1E (dark gray)
- **Operators**: #FF9500 (amber/orange)
- **Error**: #FF453A (red)
- **Text**: White with opacity variations

### Typography
- **Font**: Google Fonts "Outfit"
- **Display Number**: 64px, weight 300, auto-shrinking to 32px
- **Expression**: 20px, 50% opacity
- **Buttons**: 24px, weight 500

### Button Layout (5×4 Grid)
```
Row 1: [AC  ] [+/− ] [%  ] [÷  ]
Row 2: [7   ] [8   ] [9  ] [×  ]
Row 3: [4   ] [5   ] [6  ] [−  ]
Row 4: [1   ] [2   ] [3  ] [+  ]
Row 5: [  0  ] [.  ] [= ]
```

The "0" button spans 2 columns, with "." and "=" taking the right two columns.

## Edge Cases Handled

1. **Division by zero** → Shows "Error"
2. **Backspace on empty** → Triggers shake animation, no state change
3. **Multiple decimals** → Prevents "3.5.2"
4. **Double operators** → Replaces previous operator
5. **Very large numbers** → Scientific notation (e.g., 1.23E+10)
6. **NaN/Infinity** → Caught and displays "Error"
7. **Leading zeros** → Prevents "007", allows "0.7"
8. **Negative operands** → Handles "5 × −3" correctly
9. **Starting with operator** → Auto-prepends "0"
10. **Result as operand** → Operator after "=" continues from result

## Dependencies

- **flutter_riverpod**: ^2.5.1 — State management
- **math_expressions**: ^2.4.0 — Expression parsing and evaluation
- **google_fonts**: ^6.1.0 — Outfit typography
- **intl**: ^0.19.0 — Number formatting (scientific notation)

## Accessibility

- All buttons have semantic labels
- Display panel uses `liveRegion: true` for screen reader announcements
- Minimum tap target size: 48×48 logical pixels
- Proper color contrast for all text

## Code Quality

- No `print()` statements (production-ready)
- `const` constructors used throughout
- `RepaintBoundary` around button grid for efficiency
- No hardcoded strings (config-driven button definitions)
- Comprehensive linting with analysis_options.yaml

## Supported Platforms

- **Android**: API 21+
- **iOS**: 13.0+
- **Web**: (via Flutter Web, untested)

## Production Checklist

✅ Dark theme with specified colors
✅ Riverpod state management
✅ All animations implemented
✅ Comprehensive error handling
✅ Unit tests with 100% coverage of edge cases
✅ Accessibility features
✅ Haptic feedback
✅ Efficient rendering (RepaintBoundary)
✅ No debug statements
✅ const constructors where possible
✅ Production-ready code structure

## License

This project is provided as-is for educational and development purposes.
