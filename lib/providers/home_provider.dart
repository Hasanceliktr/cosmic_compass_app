// lib/providers/home_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/api/interpretation_service.dart';
import 'package:cosmic_compass_app/models/daily_interpretation.dart';
import 'package:cosmic_compass_app/providers/auth_provider.dart';

import 'api_provider.dart';

// InterpretationService için bir provider

// Günlük yorumu getiren asenkron provider (FutureProvider)
final dailyInterpretationProvider = FutureProvider<DailyInterpretation>((ref) async {
  
  // InterpretationService'i kullanarak API'dan veriyi çekiyoruz.
  return ref.read(interpretationServiceProvider).getDailyInterpretation();
});