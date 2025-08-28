import 'package:cosmic_compass_app/features/splash/splash_screen.dart'; // YENİ IMPORT
import 'package:flutter/material.dart';

import 'api/common/theme/app_theme.dart';

void main() {
  runApp(const CosmicCompassApp());
}

class CosmicCompassApp extends StatelessWidget {
  const CosmicCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Compass',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}