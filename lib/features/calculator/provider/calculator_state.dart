import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorState {
  final String expression;
  final String displayNumber;
  final bool isResult;
  final bool isError;

  const CalculatorState({
    required this.expression,
    required this.displayNumber,
    required this.isResult,
    required this.isError,
  });

  CalculatorState copyWith({
    String? expression,
    String? displayNumber,
    bool? isResult,
    bool? isError,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      displayNumber: displayNumber ?? this.displayNumber,
      isResult: isResult ?? this.isResult,
      isError: isError ?? this.isError,
    );
  }

  bool get isEmpty => displayNumber == '0' && expression.isEmpty;

  @override
  String toString() =>
      'CalculatorState(expression: $expression, displayNumber: $displayNumber, isResult: $isResult, isError: $isError)';
}
