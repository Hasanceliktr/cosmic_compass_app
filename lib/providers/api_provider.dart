import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/api/auth_service.dart';
import 'package:cosmic_compass_app/api/interpretation_service.dart';
import 'package:cosmic_compass_app/api/relationship_service.dart';
import 'package:cosmic_compass_app/api/user_service.dart';
import 'package:cosmic_compass_app/providers/auth_provider.dart';

// --- Merkezi Dio İstemcisi ---
// Bu provider, uygulamamızın tüm HTTP istekleri için kullanacağı
// tek, merkezi ve akıllı Dio istemcisini oluşturur.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080/api/v1', // Android emülatörü için localhost
    connectTimeout: const Duration(seconds: 15), // Bağlantı zaman aşımı
    receiveTimeout: const Duration(seconds: 15), // Cevap bekleme zaman aşımı
  ));

  // Interceptor: Tüm isteklere otomatik olarak JWT ekler.
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Her istek gönderilmeden önce, AuthProvider'dan güncel token'ı oku.
        final token = ref.read(authProvider).token;

        if (token != null) {
          // Token varsa, 'Authorization' header'ını ayarla.
          options.headers['Authorization'] = 'Bearer $token';
        }

        // İsteğin devam etmesini sağla.
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // Eğer sunucudan 401 Unauthorized hatası gelirse (token geçersiz/süresi dolmuş),
        // kullanıcıyı otomatik olarak sistemden at.
        if (e.response?.statusCode == 401) {
          print("Token geçersiz, logout tetikleniyor...");
          ref.read(authProvider.notifier).logout();
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
});


// --- API Servis Provider'ları ---
// Tüm API servisleri, yukarıda oluşturulan merkezi dioProvider'ı kullanır.
// Bu, tüm servislerin aynı konfigürasyona ve token yönetimine sahip olmasını sağlar.

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(dioProvider));
});

final interpretationServiceProvider = Provider<InterpretationService>((ref) {
  return InterpretationService(ref.watch(dioProvider));
});

final relationshipServiceProvider = Provider<RelationshipService>((ref) {
  return RelationshipService(ref.watch(dioProvider));
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref.watch(dioProvider));
});