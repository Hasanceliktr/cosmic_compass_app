// lib/features/home/widgets/daily_horoscope_card.dart

import 'package:flutter/material.dart';
import 'package:cosmic_compass_app/common/theme/app_colors.dart';
import 'package:cosmic_compass_app/models/daily_interpretation.dart';

class DailyHoroscopeCard extends StatelessWidget {
  final DailyInterpretation interpretation;

  const DailyHoroscopeCard({super.key, required this.interpretation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.primaryGradient.scale(0.8), // Temadaki gradyanı biraz koyulaştırarak kullanabiliriz.
        color: AppColors.cardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            interpretation.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            'İlgili Gezegen: ${interpretation.relevantPlanet}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.textSecondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            interpretation.interpretationText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5), // Satır aralığını artır
          ),
        ],
      ),
    );
  }
}