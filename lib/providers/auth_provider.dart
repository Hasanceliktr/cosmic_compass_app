import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/common/storage/secure_storage_service.dart';
import 'package:cosmic_compass_app/models/user_enums.dart';
import 'package:cosmic_compass_app/providers/api_provider.dart';

// 1. Dış bağımlılıklarımız için provider'lar.
final secureStorageProvider = Provider((ref) => SecureStorageService());
// Not: authServiceProvider'ı api_provider.dart'a taşıdığımız için buradan siliyoruz.

// 2. Auth state'ini temsil edecek olan sınıf
class AuthState {
  final bool isLoading;
  final String? token;
  final String? error;

  AuthState({this.isLoading = false, this.token, this.error});

  // Hataları temizlemek için yardımcı bir metot
  AuthState copyWith({bool? isLoading, String? token, String? error, bool clearError = false}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: clearError ? null : error ?? this.error,
    );
  }
}

// 3. Auth state'ini yöneten ana provider'ımız (StateNotifierProvider)
class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(AuthState()) {
    _loadTokenFromStorage();
  }

  Future<void> _loadTokenFromStorage() async {
    final token = await _ref.read(secureStorageProvider).getToken();
    if (token != null) {
      state = AuthState(token: token);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final response = await _ref.read(authServiceProvider).login(email: email, password: password);
      await _ref.read(secureStorageProvider).saveToken(response.token);
      state = AuthState(token: response.token);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // REGISTER METODUNU GÜNCELLEYELİM
  Future<void> register({
    required String name,
    required String email,
    required String password,
    Gender? gender,
    RelationshipStatus? relationshipStatus,
  }) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final response = await _ref.read(authServiceProvider).register(
        name: name,
        email: email,
        password: password,
        gender: gender,
        relationshipStatus: relationshipStatus,
      );
      await _ref.read(secureStorageProvider).saveToken(response.token);
      state = AuthState(token: response.token);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _ref.read(secureStorageProvider).deleteToken();
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});