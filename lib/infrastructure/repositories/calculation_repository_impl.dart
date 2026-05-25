/// Concrete repository implementation
/// 
/// Implements the abstract repository interface
/// Uses data sources for local/remote storage

import '../../domain/models/calculation_model.dart';
import '../../domain/repositories/calculation_repository.dart';
import '../data_sources/local/local_calculation_data_source.dart';
import '../data_sources/remote/remote_calculation_data_source.dart';

/// Production implementation of CalculationRepository
class CalculationRepositoryImpl implements CalculationRepository {
  final LocalCalculationDataSource _localDataSource;
  final RemoteCalculationDataSource _remoteDataSource;

  CalculationRepositoryImpl({
    required LocalCalculationDataSource localDataSource,
    required RemoteCalculationDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<void> clearHistory() async {
    await _localDataSource.clearHistory();
  }

  @override
  Future<void> deleteCalculation(String id) async {
    await _localDataSource.deleteCalculation(id);
  }

  @override
  Future<List<Calculation>> getHistory() async {
    return _localDataSource.getHistory();
  }

  @override
  Future<void> saveCalculation(Calculation calculation) async {
    // Save locally first
    await _localDataSource.saveCalculation(calculation);
    
    // Optional: Sync to remote
    try {
      await _remoteDataSource.syncCalculation(calculation);
    } catch (e) {
      // Log error but don't fail - local save is priority
      print('Remote sync failed: $e');
    }
  }
}
