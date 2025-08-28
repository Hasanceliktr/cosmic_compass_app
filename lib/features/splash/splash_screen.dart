import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Doğrudan stil vermek yerine, temanın stilini kullanıyoruz.
        // Bu, temanın her yerine yayılmasını sağlar.
        child: Text(
          'Cosmic Compass',
          style: Theme
              .of(context)
              .textTheme
              .displayLarge,
        ),
      ),
    );
  }
}