import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_wrapper.dart';
import 'common/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CosmicCompassApp(),
    ),
  );
}

class CosmicCompassApp extends StatelessWidget {
  const CosmicCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Compass',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}