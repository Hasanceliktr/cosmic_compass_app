// lib/providers/natal_chart_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/models/natal_chart_data.dart';
import 'package:cosmic_compass_app/providers/api_provider.dart';

final natalChartProvider = FutureProvider<NatalChartData>((ref) {
  // api_provider.dart'ta tanımladığımız merkezi servisi kullanıyoruz.
  final interpretationService = ref.watch(interpretationServiceProvider);
  return interpretationService.getNatalChartData();
});