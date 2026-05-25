/// Local data source - SharedPreferences implementation
///
/// Handles local storage of calculation history

import '../../domain/models/calculation_model.dart';

/// Abstract interface for local data source
abstract class LocalCalculationDataSource {
  Future<List<Calculation>> getHistory();
  Future<void> saveCalculation(Calculation calculation);
  Future<void> deleteCalculation(String id);
  Future<void> clearHistory();
}

/// Concrete implementation using SharedPreferences
/// (To be implemented when SharedPreferences is added to pubspec.yaml)
class LocalCalculationDataSourceImpl implements LocalCalculationDataSource {
  static const String _storageKey = 'calculation_history';

  @override
  Future<List<Calculation>> getHistory() async {
    // TODO: Implement with SharedPreferences
    return [];
  }

  @override
  Future<void> saveCalculation(Calculation calculation) async {
    // TODO: Implement with SharedPreferences
  }

  @override
  Future<void> deleteCalculation(String id) async {
    // TODO: Implement with SharedPreferences
  }

  @override
  Future<void> clearHistory() async {
    // TODO: Implement with SharedPreferences
  }
}
