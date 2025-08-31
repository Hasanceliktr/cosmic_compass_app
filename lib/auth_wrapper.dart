import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/common/main_screen.dart';
import 'package:cosmic_compass_app/features/auth/complete_profile_screen.dart'; // YENİ IMPORT
import 'package:cosmic_compass_app/features/auth/auth_gate_screen.dart'; // veya OnboardingScreen
import 'package:cosmic_compass_app/features/splash/splash_screen.dart';
import 'package:cosmic_compass_app/providers/auth_provider.dart';
import 'package:cosmic_compass_app/providers/user_provider.dart'; // YENİ IMPORT

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.token != null) {
      // 1. Kullanıcı giriş yapmış, şimdi profilini kontrol et.
      final userProfileAsync = ref.watch(userProfileProvider);

      return userProfileAsync.when(
        // 2. Profil bilgisi yüklenirken Splash göster.
        loading: () => const SplashScreen(),

        // 3. Profil alınırken bir hata olursa, çıkış yaptırıp giriş ekranına at.
        error: (err, stack) {
          // Hatanın sebebini loglamak iyi bir fikirdir.
          print("Error fetching user profile: $err");
          // Otomatik logout yapabiliriz.
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   ref.read(authProvider.notifier).logout();
          // });
          return const AuthGateScreen();
        },

        // 4. Profil bilgisi başarıyla geldiyse...
        data: (userProfile) {
          if (userProfile.hasBirthInfo) {
            // 4a. Doğum bilgisi VARSA -> Ana ekrana git
            return const MainScreen();
          } else {
            // 4b. Doğum bilgisi YOKSA -> "Profili Tamamla" ekranına git
            return const CompleteProfileScreen();
          }
        },
      );
    } else {
      // 5. Kullanıcı hiç giriş yapmamışsa -> Auth kapısına git.
      return const AuthGateScreen();
    }
  }
}