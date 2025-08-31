import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cosmic_compass_app/providers/home_provider.dart';
import 'package:cosmic_compass_app/features/home/widgets/home_header.dart';
import 'package:cosmic_compass_app/features/home/widgets/feature_card.dart';

// Diğer ekranları import edelim ki navigasyon yapabilelim
import 'package:cosmic_compass_app/features/ask_question/ask_question_screen.dart';
import 'package:cosmic_compass_app/features/synastry/synastry_screen.dart';

import '../natalchart/natal_chart_screen.dart';
import 'daily_horoscope_card.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyInterpretationAsyncValue = ref.watch(dailyInterpretationProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                const SizedBox(height: 20),

                dailyInterpretationAsyncValue.when(
                  data: (interpretation) => DailyHoroscopeCard(interpretation: interpretation),
                  loading: () => const Center(child: CircularProgressIndicator()), // TODO: Skeleton loader ile değiştir
                  error: (err, stack) => Center(
                    child: Text(
                      'Günlük yorum yüklenirken bir hata oluştu.\n${err.toString()}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    FeatureCard(
                      title: 'Doğum Haritam',
                      icon: FontAwesomeIcons.circleNodes,
                      onTap: () {
                        // TODO: Bu navigasyon daha sonra merkezi bir provider ile yönetilmeli
                        // Şimdilik doğrudan sayfayı açıyoruz.
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const NatalChartScreen()),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    FeatureCard(
                      title: 'Yıldızlara Sor',
                      icon: FontAwesomeIcons.solidStar,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const AskQuestionScreen()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    FeatureCard(
                      title: 'İlişki Uyumu',
                      icon: FontAwesomeIcons.solidHeart,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SynastryScreen()),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    FeatureCard(
                      title: 'Gezegenlerim',
                      icon: FontAwesomeIcons.earthEurope,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Gezegenlerim özelliği yakında!')),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}