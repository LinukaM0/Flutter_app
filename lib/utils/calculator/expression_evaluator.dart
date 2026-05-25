import 'package:math_expressions/math_expressions.dart';

class ExpressionEvaluator {
  static const String multiplySymbol = '×';
  static const String divideSymbol = '÷';
  static const String minusSymbol = '−';
  static const String asterisk = '*';
  static const String forwardSlash = '/';
  static const String minus = '-';

  /// Evaluates a mathematical expression string.
  /// Replaces × with *, ÷ with /, and − with - for math_expressions compatibility.
  /// Returns a double result or throws an exception on error.
  static double evaluate(String expression) {
    if (expression.isEmpty) {
      throw Exception('Empty expression');
    }

    try {
      // Replace display symbols with math_expressions symbols
      String normalizedExpression = expression
          .replaceAll(multiplySymbol, asterisk)
          .replaceAll(divideSymbol, forwardSlash)
          .replaceAll(minusSymbol, minus)
          .trim();

      // Remove trailing operators
      while (normalizedExpression.isNotEmpty &&
          '+-*/'.contains(
              normalizedExpression[normalizedExpression.length - 1])) {
        normalizedExpression =
            normalizedExpression.substring(0, normalizedExpression.length - 1);
      }

      if (normalizedExpression.isEmpty) {
        throw Exception('Invalid expression after trimming');
      }

      // Parse and evaluate
      final parser = Parser();
      final expression_obj = parser.parse(normalizedExpression);
      final contextModel = ContextModel();
      final result = expression_obj.evaluate(EvaluationType.REAL, contextModel);

      // Check for invalid results
      if (result.isNaN || result.isInfinite) {
        throw Exception('Invalid calculation result');
      }

      return result as double;
    } catch (e) {
      throw Exception('Calculation error: ${e.toString()}');
    }
  }
}
