import 'package:intl/intl.dart';

class NumberFormatter {
  static const int largeNumberThreshold = 12;

  /// Formats a number for display on the calculator.
  /// Uses scientific notation for numbers above 12 digits.
  static String format(double number) {
    // Handle special cases
    if (number.isNaN || number.isInfinite) {
      return 'Error';
    }

    // Convert to string and check for scientific notation requirement
    final absNumber = number.abs();
    final integerPart = absNumber.toInt();
    final stringLength = integerPart.toString().length;

    if (stringLength > largeNumberThreshold) {
      // Use scientific notation
      return NumberFormat('0.0E0').format(number);
    }

    // Format with appropriate decimal places
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      // Format with up to 12 decimal places, removing trailing zeros
      String formatted = number.toStringAsFixed(12);
      formatted = formatted.replaceAll(RegExp(r'0+$'), '');
      formatted = formatted.replaceAll(RegExp(r'\.$'), '');
      return formatted;
    }
  }

  /// Parses a display string to a double.
  static double parse(String displayNumber) {
    return double.parse(displayNumber);
  }

  /// Checks if a string represents a valid number.
  static bool isValidNumber(String value) {
    try {
      double.parse(value);
      return true;
    } catch (_) {
      return false;
    }
  }
}
