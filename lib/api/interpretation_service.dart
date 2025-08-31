// lib/api/interpretation_service.dart

import 'package:dio/dio.dart';

import '../models/ask_question_response.dart';
import '../models/daily_interpretation.dart';
import '../models/natal_chart_data.dart';

class InterpretationService {
  final Dio _dio;
  // TODO: Dio instance'ını ve token yönetimini merkezi hale getirmeliyiz.
  // Bu, bir sonraki refactoring adımı olacak. Şimdilik böyle devam edelim.
  InterpretationService(this._dio);

  Future<DailyInterpretation> getDailyInterpretation() async {
    try {
      // options: Options(...) bölümünü tamamen sildik,
      // çünkü token'ı artık interceptor otomatik ekliyor.
      final response = await _dio.get('/interpretations/daily');
      return DailyInterpretation.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Günlük yorum alınamadı: ${e.message}');
    }
  }

  Future<NatalChartData> getNatalChartData() async {
    // ŞİMDİLİK SAHTE VERİ DÖNDÜRELİM (BACKEND HAZIR OLANA KADAR)
    // Bu, UI'ı backend'den bağımsız geliştirmemizi sağlar.
    await Future.delayed(const Duration(seconds: 1)); // 1 saniyelik sahte bekleme

    return NatalChartData(
      sun: PlanetInfo(name: 'Güneş', sign: 'Başak', house: '7. Ev'),
      moon: PlanetInfo(name: 'Ay', sign: 'Yengeç', house: '6. Ev'),
      ascendant: PlanetInfo(name: 'Yükselen', sign: 'Balık', house: '1. Ev'),
    );
  }

  Future<AskQuestionResponse> askQuestion(String question) async {
    try {
      final response = await _dio.post(
        '/interpretations/ask',
        data: {'question': question},
      );
      return AskQuestionResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 402) { // 402 Payment Required
        throw Exception('Soru sorma hakkınız kalmamıştır.');
      }
      throw Exception('Soru gönderilemedi: ${e.message}');
    }
  }
}