// lib/api/user_service.dart

import 'package:dio/dio.dart';
import 'package:cosmic_compass_app/models/user_profile.dart';

class UserService {
  final Dio _dio;
  UserService(this._dio);

  // Giriş yapmış kullanıcının profilini getiren metot
  Future<UserProfile> getMe() async {
    try {
      final response = await _dio.get('/users/me');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Kullanıcı profili alınamadı: ${e.message}');
    }
  }

// TODO: updateFcmToken ve diğer user metotları da bu sınıfa taşınabilir.
}