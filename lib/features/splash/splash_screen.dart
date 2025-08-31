import 'package:flutter/material.dart';

import '../../common/widgets/primary_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold'un body'sine biraz boşluk ekleyelim ki buton kenarlara yapışmasın
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Ortalamak için
            children: [
              Text(
                'Cosmic Compass',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 40), // İki widget arasına boşluk koyar

              // --- YENİ WIDGET'IMIZI KULLANIYORUZ ---
              PrimaryButton(
                text: 'Get Started',
                onPressed: () {
                  // Butona tıklandığında konsola bir mesaj yazdıralım
                  print('Get Started button pressed!');
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}