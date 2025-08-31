import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/common/widgets/primary_button.dart';
import 'package:cosmic_compass_app/models/person_info.dart';
import 'package:cosmic_compass_app/models/synastry_report.dart';
import 'package:cosmic_compass_app/providers/api_provider.dart';
import 'package:cosmic_compass_app/features/synastry/widgets/person_info_form.dart';

import '../home/widgets/person_info_controllers.dart'; // Bu widget'ı da oluşturacağız

final synastryReportProvider = StateProvider<AsyncValue<SynastryReport?>>((ref) => const AsyncData(null));

class SynastryScreen extends ConsumerStatefulWidget {
  const SynastryScreen({super.key});

  @override
  ConsumerState<SynastryScreen> createState() => _SynastryScreenState();
}

class _SynastryScreenState extends ConsumerState<SynastryScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Formları yönetmek için Controller'lar
  late final PersonInfoControllers _controllers1;
  late final PersonInfoControllers _controllers2;

  @override
  void initState() {
    super.initState();
    _controllers1 = PersonInfoControllers();
    _controllers2 = PersonInfoControllers();
  }

  @override
  void dispose() {
    _controllers1.dispose();
    _controllers2.dispose();
    super.dispose();
  }

  Future<void> _submitForms() async {
    final isForm1Valid = _formKey1.currentState?.validate() ?? false;
    final isForm2Valid = _formKey2.currentState?.validate() ?? false;

    if (!isForm1Valid || !isForm2Valid) return;

    ref.read(synastryReportProvider.notifier).state = const AsyncLoading();

    try {
      final person1 = _controllers1.toPersonInfo();
      final person2 = _controllers2.toPersonInfo();

      final report = await ref.read(relationshipServiceProvider).getSynastryReport(
        firstPerson: person1,
        secondPerson: person2,
      );
      ref.read(synastryReportProvider.notifier).state = AsyncData(report);
    } catch (e) {
      ref.read(synastryReportProvider.notifier).state = AsyncError(e, StackTrace.current);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(synastryReportProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('İlişki Uyumu')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Birinci Kişi', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            PersonInfoForm(formKey: _formKey1, controllers: _controllers1),
            const SizedBox(height: 30),
            Text('İkinci Kişi', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            PersonInfoForm(formKey: _formKey2, controllers: _controllers2),
            const SizedBox(height: 30),
            PrimaryButton(
              onPressed: state.isLoading ? null : _submitForms,
              text: state.isLoading ? 'Hesaplanıyor...' : 'Uyumu Hesapla',
            ),
            const SizedBox(height: 20),
            state.when(
              data: (report) {
                if (report == null) return const SizedBox.shrink();
                return Column(
                  children: [
                    Text(report.title, style: Theme.of(context).textTheme.headlineSmall),
                    Text("Uyum Skoru: ${report.relationshipScore.toStringAsFixed(1)}"),
                    const SizedBox(height: 10),
                    Text(report.summary, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Hata: ${err.toString()}', style: const TextStyle(color: Colors.red))),
              skipLoadingOnReload: true,
            ),
          ],
        ),
      ),
    );
  }
}