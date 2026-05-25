import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calculator_state.dart';
import '../../utils/calculator/expression_evaluator.dart';
import '../../utils/calculator/number_formatter.dart';

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  static const String multiply = '×';
  static const String divide = '÷';
  static const String subtract = '−';
  static const String add = '+';
  static const Set<String> operators = {multiply, divide, subtract, add};
  static const double percentDivisor = 100.0;

  CalculatorNotifier()
      : super(
          const CalculatorState(
            expression: '',
            displayNumber: '0',
            isResult: false,
            isError: false,
          ),
        );

  /// Input a digit (0-9).
  void inputDigit(String digit) {
    if (state.isError) {
      clear();
    }

    if (state.isResult) {
      // Start fresh if coming from result
      state = CalculatorState(
        expression: '',
        displayNumber: digit,
        isResult: false,
        isError: false,
      );
      return;
    }

    // Prevent leading zeros (except "0." cases)
    if (state.displayNumber == '0' && digit != '0') {
      state = state.copyWith(displayNumber: digit);
    } else if (state.displayNumber != '0') {
      state = state.copyWith(
        displayNumber: state.displayNumber + digit,
      );
    }
    // else: ignore additional leading zeros
  }

  /// Input an operator (+, -, ×, ÷).
  void inputOperator(String op) {
    if (state.isError) {
      clear();
      return;
    }

    if (!operators.contains(op)) return;

    // If coming from a result, use the result as the operand
    if (state.isResult) {
      state = CalculatorState(
        expression: state.displayNumber + ' ' + op + ' ',
        displayNumber: '0',
        isResult: false,
        isError: false,
      );
      return;
    }

    String newExpression = state.expression.trim();
    String currentNumber = state.displayNumber;

    // If current display is "0" (no number entered after last operator)
    if (currentNumber == '0') {
      // Just replace the last operator if expression ends with one
      if (newExpression.isNotEmpty &&
          operators.contains(newExpression[newExpression.length - 1])) {
        newExpression =
            newExpression.substring(0, newExpression.length - 1).trim();
      }
    } else {
      // User entered a number, add it to expression
      if (newExpression.isEmpty) {
        newExpression = currentNumber;
      } else {
        newExpression = newExpression + ' ' + currentNumber;
      }
    }

    // Add the new operator
    state = CalculatorState(
      expression: newExpression + ' ' + op + ' ',
      displayNumber: '0',
      isResult: false,
      isError: false,
    );
  }

  /// Input a decimal point.
  void inputDecimal() {
    if (state.isError) {
      clear();
    }

    if (state.isResult) {
      state = CalculatorState(
        expression: '',
        displayNumber: '0.',
        isResult: false,
        isError: false,
      );
      return;
    }

    // Only add decimal if not already present
    if (!state.displayNumber.contains('.')) {
      state = state.copyWith(
        displayNumber: state.displayNumber + '.',
      );
    }
  }

  /// Input percentage (divide current number by 100).
  void inputPercent() {
    if (state.isError) return;

    try {
      final currentValue = NumberFormatter.parse(state.displayNumber);
      final percentValue = currentValue / percentDivisor;
      final formatted = NumberFormatter.format(percentValue);

      state = state.copyWith(
        displayNumber: formatted,
        isError: false,
      );
    } catch (_) {
      state = state.copyWith(isError: true);
    }
  }

  /// Toggle the sign of the current displayed number.
  void toggleSign() {
    if (state.isError) return;

    try {
      final currentValue = NumberFormatter.parse(state.displayNumber);
      if (currentValue == 0) {
        // Don't change 0 to -0
        return;
      }

      final toggledValue = -currentValue;
      final formatted = NumberFormatter.format(toggledValue);

      state = state.copyWith(displayNumber: formatted);
    } catch (_) {
      state = state.copyWith(isError: true);
    }
  }

  /// Backspace: delete the last character of the displayed number.
  void backspace() {
    if (state.displayNumber.isEmpty || state.displayNumber == '0') {
      // Trigger shake animation via error flag (caller will handle animation)
      return;
    }

    final newDisplay = state.displayNumber.substring(
      0,
      state.displayNumber.length - 1,
    );

    state = state.copyWith(
      displayNumber: newDisplay.isEmpty ? '0' : newDisplay,
    );
  }

  /// Clear current entry (C) - keep expression if present.
  void clearCurrentEntry() {
    state = state.copyWith(
      displayNumber: '0',
      isResult: false,
      isError: false,
    );
  }

  /// Full reset (AC) - clear everything.
  void clear() {
    state = const CalculatorState(
      expression: '',
      displayNumber: '0',
      isResult: false,
      isError: false,
    );
  }

  /// Evaluate the expression and show result.
  void evaluate() {
    if (state.isError) {
      clear();
      return;
    }

    if (state.expression.isEmpty && state.displayNumber == '0') {
      state = state.copyWith(isResult: false);
      return;
    }

    try {
      // Build complete expression
      final fullExpression = state.expression.trim().isEmpty
          ? state.displayNumber
          : state.expression + state.displayNumber;

      // Evaluate using the evaluator
      final result = ExpressionEvaluator.evaluate(fullExpression);
      final formatted = NumberFormatter.format(result);

      state = CalculatorState(
        expression: state.expression + state.displayNumber,
        displayNumber: formatted,
        isResult: true,
        isError: false,
      );
    } catch (_) {
      state = state.copyWith(isError: true);
    }
  }
}
