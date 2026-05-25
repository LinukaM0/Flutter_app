import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/calculator_notifier.dart';
import '../controllers/calculator_state.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});
