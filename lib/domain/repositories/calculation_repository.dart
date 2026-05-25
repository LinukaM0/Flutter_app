/// Abstract repository interface for calculations
///
/// Defines the contract for calculation storage operations.
/// Implementation should be in infrastructure layer.

import '../models/calculation_model.dart';

abstract class CalculationRepository {
  /// Fetch calculation history
  Future<List<Calculation>> getHistory();

  /// Save a calculation
  Future<void> saveCalculation(Calculation calculation);

  /// Delete a calculation
  Future<void> deleteCalculation(String id);

  /// Clear all history
  Future<void> clearHistory();
}
