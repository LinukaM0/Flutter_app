/// Value Objects - Immutable, domain-specific types
/// 
/// These represent domain concepts that are best expressed
/// as value objects rather than entities

/// Represents a mathematical operator
class MathOperator {
  final String symbol;
  final String displaySymbol;

  const MathOperator({
    required this.symbol,
    required this.displaySymbol,
  });

  static const add = MathOperator(symbol: '+', displaySymbol: '+');
  static const subtract = MathOperator(symbol: '-', displaySymbol: '−');
  static const multiply = MathOperator(symbol: '*', displaySymbol: '×');
  static const divide = MathOperator(symbol: '/', displaySymbol: '÷');

  static const List<MathOperator> all = [add, subtract, multiply, divide];

  bool get isOperator => true;

  @override
  String toString() => displaySymbol;
}
