import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/providers/natal_chart_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cosmic_compass_app/common/theme/app_colors.dart';

class NatalChartScreen extends ConsumerWidget {
  const NatalChartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final natalChartAsyncValue = ref.watch(natalChartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doğum Haritam'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: natalChartAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Hata: ${err.toString()}')),
        data: (chartData) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildPlanetInfoTile(
                icon: FontAwesomeIcons.sun,
                color: AppColors.accent,
                title: 'Güneş',
                subtitle: '${chartData.sun.sign} Burcu - ${chartData.sun.house}',
              ),
              const SizedBox(height: 12),
              _buildPlanetInfoTile(
                icon: FontAwesomeIcons.moon,
                color: AppColors.textSecondary,
                title: 'Ay',
                subtitle: '${chartData.moon.sign} Burcu - ${chartData.moon.house}',
              ),
              const SizedBox(height: 12),
              _buildPlanetInfoTile(
                icon: FontAwesomeIcons.arrowUp,
                color: Colors.blueAccent,
                title: 'Yükselen',
                subtitle: '${chartData.ascendant.sign} Burcu',
              ),
              // TODO: Diğer gezegenler de buraya eklenecek
            ],
          );
        },
      ),
    );
  }

  // Yeniden kullanılabilir bir liste elemanı widget'ı
  Widget _buildPlanetInfoTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          FaIcon(icon, color: color, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
            ],
          )
        ],
      ),
    );
  }
}