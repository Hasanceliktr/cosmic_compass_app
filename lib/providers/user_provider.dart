// lib/providers/user_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/api/user_service.dart';
import 'package:cosmic_compass_app/models/user_profile.dart';
import 'package:cosmic_compass_app/providers/api_provider.dart';
import 'package:cosmic_compass_app/providers/auth_provider.dart';

// UserService için merkezi bir provider
final userServiceProvider = Provider((ref) => UserService(ref.watch(dioProvider)));

// Giriş yapmış kullanıcının profilini (asenkron olarak) sağlayan provider
final userProfileProvider = FutureProvider<UserProfile>((ref) {
  // Bu provider, kullanıcının giriş/çıkış durumuna (token varlığına) bağlıdır.
  // Kullanıcı çıkış yaptığında (token null olduğunda), bu provider otomatik olarak
  // kendini geçersiz kılar ve yeniden çağrıldığında veriyi tekrar çeker.
  final authState = ref.watch(authProvider);
  if (authState.token == null) {
    // Eğer kullanıcı giriş yapmamışsa, bu provider'ın bir hata fırlatması gerekir.
    // Çünkü bu provider'a sadece giriş yapmış kullanıcıların erişebildiği ekranlardan ulaşılmalıdır.
    throw Exception('Kullanıcı giriş yapmamış.');
  }

  // UserService'i kullanarak veriyi çek.
  return ref.watch(userServiceProvider).getMe();
});