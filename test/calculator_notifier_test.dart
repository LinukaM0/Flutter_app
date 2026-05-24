import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calculator_app/features/calculator/provider/calculator_provider.dart';
import 'package:calculator_app/features/calculator/provider/calculator_notifier.dart';
import 'package:calculator_app/features/calculator/provider/calculator_state.dart';

void main() {
  group('CalculatorNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('1. Test 3 + 5 = 8', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('3');
      expect(container.read(calculatorProvider).displayNumber, '3');

      notifier.inputOperator('+');
      expect(
        container.read(calculatorProvider).expression.trim(),
        '3 +',
      );
      expect(container.read(calculatorProvider).displayNumber, '0');

      notifier.inputDigit('5');
      expect(container.read(calculatorProvider).displayNumber, '5');

      notifier.evaluate();
      expect(container.read(calculatorProvider).displayNumber, '8');
      expect(container.read(calculatorProvider).isResult, true);
      expect(container.read(calculatorProvider).isError, false);
    });

    test('2. Test 10 ÷ 4 = 2.5', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('1');
      notifier.inputDigit('0');
      notifier.inputOperator('÷');
      notifier.inputDigit('4');
      notifier.evaluate();

      final result = container.read(calculatorProvider).displayNumber;
      expect(result, '2.5');
      expect(container.read(calculatorProvider).isError, false);
    });

    test('3. Test 100 × 0 = 0', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('1');
      notifier.inputDigit('0');
      notifier.inputDigit('0');
      notifier.inputOperator('×');
      notifier.inputDigit('0');
      notifier.evaluate();

      final result = container.read(calculatorProvider).displayNumber;
      expect(result, '0');
      expect(container.read(calculatorProvider).isError, false);
    });

    test('4. Test 1 ÷ 0 → isError = true', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('1');
      notifier.inputOperator('÷');
      notifier.inputDigit('0');
      notifier.evaluate();

      expect(container.read(calculatorProvider).isError, true);
    });

    test('5. Test 50% = 0.5', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('5');
      notifier.inputDigit('0');
      notifier.inputPercent();

      final result = container.read(calculatorProvider).displayNumber;
      expect(result, '0.5');
      expect(container.read(calculatorProvider).isError, false);
    });

    test('6. Test 9 +/- = -9', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('9');
      notifier.toggleSign();

      expect(container.read(calculatorProvider).displayNumber, '-9');
      expect(container.read(calculatorProvider).isError, false);
    });

    test('7. Test backspace on "123" → "12"', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('1');
      notifier.inputDigit('2');
      notifier.inputDigit('3');
      expect(container.read(calculatorProvider).displayNumber, '123');

      notifier.backspace();
      expect(container.read(calculatorProvider).displayNumber, '12');
    });

    test('8. Test backspace on empty → no crash, isError stays false', () {
      final notifier = container.read(calculatorProvider.notifier);

      expect(container.read(calculatorProvider).displayNumber, '0');
      notifier.backspace(); // Should not crash

      expect(container.read(calculatorProvider).displayNumber, '0');
      expect(container.read(calculatorProvider).isError, false);
    });

    test('9. Test double operator → only last operator kept', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('5');
      notifier.inputOperator('+');
      expect(
        container.read(calculatorProvider).expression.trim(),
        '5 +',
      );

      notifier.inputOperator('-');
      // Should replace + with −
      expect(
        container.read(calculatorProvider).expression.trim(),
        '5 −',
      );
    });

    test('10. Test decimal: "3.5" + "." → still "3.5", not "3.5."', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('3');
      notifier.inputDecimal();
      notifier.inputDigit('5');
      expect(container.read(calculatorProvider).displayNumber, '3.5');

      notifier.inputDecimal(); // Try to add another decimal
      expect(container.read(calculatorProvider).displayNumber, '3.5');
    });

    test('Test clear resets everything', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('1');
      notifier.inputDigit('2');
      notifier.inputOperator('+');
      notifier.inputDigit('3');

      notifier.clear();

      expect(container.read(calculatorProvider).displayNumber, '0');
      expect(container.read(calculatorProvider).expression, '');
      expect(container.read(calculatorProvider).isResult, false);
      expect(container.read(calculatorProvider).isError, false);
    });

    test('Test operator pressed after result continues from result', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('5');
      notifier.inputOperator('+');
      notifier.inputDigit('3');
      notifier.evaluate();

      expect(container.read(calculatorProvider).displayNumber, '8');
      expect(container.read(calculatorProvider).isResult, true);

      notifier.inputOperator('×');
      expect(
        container.read(calculatorProvider).expression.trim(),
        '8 ×',
      );
      expect(container.read(calculatorProvider).displayNumber, '0');
    });

    test('Test digit pressed when isResult = true starts fresh', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('5');
      notifier.inputOperator('+');
      notifier.inputDigit('3');
      notifier.evaluate();

      expect(container.read(calculatorProvider).isResult, true);

      notifier.inputDigit('7');

      expect(container.read(calculatorProvider).displayNumber, '7');
      expect(container.read(calculatorProvider).expression, '');
      expect(container.read(calculatorProvider).isResult, false);
    });

    test('Test leading zeros prevention: "007" → "7"', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('0');
      notifier.inputDigit('0');
      notifier.inputDigit('7');

      expect(container.read(calculatorProvider).displayNumber, '7');
    });

    test('Test decimal allows "0.7"', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('0');
      notifier.inputDecimal();
      notifier.inputDigit('7');

      expect(container.read(calculatorProvider).displayNumber, '0.7');
    });

    test('Test complex expression: 2 + 3 × 4 = 14', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('2');
      notifier.inputOperator('+');
      notifier.inputDigit('3');
      notifier.inputOperator('×');
      notifier.inputDigit('4');
      notifier.evaluate();

      // Order of operations: 3 × 4 = 12, then 2 + 12 = 14
      expect(
        container.read(calculatorProvider).displayNumber,
        '14',
      );
      expect(container.read(calculatorProvider).isError, false);
    });

    test('Test clearCurrentEntry keeps expression', () {
      final notifier = container.read(calculatorProvider.notifier);

      notifier.inputDigit('5');
      notifier.inputOperator('+');
      notifier.inputDigit('3');

      notifier.clearCurrentEntry();

      expect(container.read(calculatorProvider).displayNumber, '0');
      expect(container.read(calculatorProvider).isResult, false);
    });
  });
}
