/// DTO to Domain Model Mapper
/// 
/// Converts data transfer objects to domain models

import '../../domain/models/calculation_model.dart';

/// CalculationDTO - Data Transfer Object for API/Storage
class CalculationDTO {
  final String expression;
  final String result;
  final String timestamp;

  CalculationDTO({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  factory CalculationDTO.fromJson(Map<String, dynamic> json) => CalculationDTO(
        expression: json['expression'] as String,
        result: json['result'] as String,
        timestamp: json['timestamp'] as String,
      );

  Map<String, dynamic> toJson() => {
        'expression': expression,
        'result': result,
        'timestamp': timestamp,
      };
}

/// Mapper for converting between CalculationDTO and Calculation model
class CalculationMapper {
  /// Convert DTO to Domain Model
  static Calculation toDomain(CalculationDTO dto) {
    return Calculation(
      expression: dto.expression,
      result: dto.result,
      timestamp: DateTime.parse(dto.timestamp),
    );
  }

  /// Convert Domain Model to DTO
  static CalculationDTO toDTO(Calculation calculation) {
    return CalculationDTO(
      expression: calculation.expression,
      result: calculation.result,
      timestamp: calculation.timestamp.toIso8601String(),
    );
  }

  /// Convert list of DTOs to Domain Models
  static List<Calculation> toDomainList(List<CalculationDTO> dtos) {
    return dtos.map(toDomain).toList();
  }

  /// Convert list of Domain Models to DTOs
  static List<CalculationDTO> toDTOList(List<Calculation> calculations) {
    return calculations.map(toDTO).toList();
  }
}
