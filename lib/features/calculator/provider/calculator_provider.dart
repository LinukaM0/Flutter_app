import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calculator_notifier.dart';
import 'calculator_state.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});
