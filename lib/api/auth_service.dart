import 'package:dio/dio.dart';
import 'package:cosmic_compass_app/models/auth_response.dart';
import 'package:cosmic_compass_app/models/user_enums.dart'; // Bu dosyayı birazdan oluşturacağız

class AuthService {
  final Dio _dio;
  AuthService(this._dio);

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    Gender? gender,
    RelationshipStatus? relationshipStatus,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          // Enum'ları backend'in beklediği string'e çeviriyoruz.
          // Eğer null iseler, JSON'a eklenmeyecekler.
          if (gender != null) 'gender': gender.name,
          if (relationshipStatus != null) 'relationshipStatus': relationshipStatus.name,
        },
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('Bu e-posta adresi zaten kullanımda.');
      }
      if (e.response != null) {
        final detail = e.response?.data['detail'] ?? 'Bilinmeyen bir hata oluştu.';
        throw Exception('Kayıt başarısız: $detail');
      }
      throw Exception('Bir ağ hatası oluştu. Lütfen tekrar deneyin.');
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('E-posta veya şifre hatalı.');
      }
      if (e.response != null) {
        final detail = e.response?.data['detail'] ?? 'Bilinmeyen bir hata oluştu.';
        throw Exception('Giriş başarısız: $detail');
      }
      throw Exception('Bir ağ hatası oluştu. Lütfen tekrar deneyin.');
    }
  }
}