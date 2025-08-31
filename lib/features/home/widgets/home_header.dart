// lib/features/home/widgets/home_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/user_provider.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userProfileProvider'ı dinliyoruz.
    final userProfileAsyncValue = ref.watch(userProfileProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider'ın durumuna göre (loading, error, data) farklı metinler gösterelim
          userProfileAsyncValue.when(
            data: (user) => Text(
              'Hoş Geldin, ${user.name}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            loading: () => const Text(
              'Yükleniyor...',
              style: TextStyle(color: Colors.white),
            ),
            error: (err, stack) => const Text(
              'Merhaba, Maceracı',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'İşte günün kozmik rehberi...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}