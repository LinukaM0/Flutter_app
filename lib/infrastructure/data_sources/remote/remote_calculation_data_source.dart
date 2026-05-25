/// Remote data source - API client
/// 
/// Handles remote API calls for calculation operations
/// (Optional for this calculator, can be extended for cloud sync)

import '../../domain/models/calculation_model.dart';

/// Abstract interface for remote data source
abstract class RemoteCalculationDataSource {
  Future<List<Calculation>> getHistory();
  Future<void> syncCalculation(Calculation calculation);
}

/// Concrete implementation using HTTP/Dio
/// (To be implemented when remote API is available)
class RemoteCalculationDataSourceImpl implements RemoteCalculationDataSource {
  static const String _apiBaseUrl = 'https://api.example.com';

  @override
  Future<List<Calculation>> getHistory() async {
    // TODO: Implement with HTTP/Dio client
    return [];
  }

  @override
  Future<void> syncCalculation(Calculation calculation) async {
    // TODO: Implement with HTTP/Dio client
  }
}
