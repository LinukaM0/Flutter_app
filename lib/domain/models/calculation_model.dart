/// Calculation model - Business entity
///
/// Pure Dart class representing a calculation
/// No Flutter dependencies

class Calculation {
  final String expression;
  final String result;
  final DateTime timestamp;

  Calculation({
    required this.expression,
    required this.result,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() => {
        'expression': expression,
        'result': result,
        'timestamp': timestamp.toIso8601String(),
      };

  /// Create from JSON
  factory Calculation.fromJson(Map<String, dynamic> json) {
    return Calculation(
      expression: json['expression'] as String,
      result: json['result'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  String toString() =>
      'Calculation(expression: $expression, result: $result, timestamp: $timestamp)';
}
