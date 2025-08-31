// lib/api/relationship_service.dart

import 'package:dio/dio.dart';

import '../models/person_info.dart';
import '../models/synastry_report.dart';

class RelationshipService {
  final Dio _dio;
  RelationshipService(this._dio);

  Future<SynastryReport> getSynastryReport({
    required PersonInfo firstPerson,
    required PersonInfo secondPerson,
  }) async {
    try {
      final response = await _dio.post(
        '/relationships/synastry-report',
        data: {
          'firstPerson': firstPerson.toJson(),
          'secondPerson': secondPerson.toJson(),
        },
      );
      return SynastryReport.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('Bu özellik sadece Premium üyelere özeldir.');
      }
      throw Exception('Uyum raporu oluşturulamadı: ${e.message}');
    }
  }
}