

// Bu provider, sadece bu ekranda anlık durumu (yükleniyor, cevap geldi vb.) yönetir.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/widgets/primary_button.dart';
import '../../models/ask_question_response.dart';
import '../../providers/api_provider.dart';

final askQuestionStateProvider = StateProvider<AsyncValue<AskQuestionResponse?>>((ref) => const AsyncData(null));

class AskQuestionScreen extends ConsumerStatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  ConsumerState<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends ConsumerState<AskQuestionScreen> {
  final _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _submitQuestion() async {
    if (_questionController.text.trim().length < 10) {
      // Basit bir ön validasyon
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sorunuz en az 10 karakter olmalıdır.')),
      );
      return;
    }

    // Yüklenme durumunu başlat
    ref.read(askQuestionStateProvider.notifier).state = const AsyncLoading();

    try {
      final service = ref.read(interpretationServiceProvider);
      final response = await service.askQuestion(_questionController.text.trim());
      // Başarılı cevap durumunu ayarla
      ref.read(askQuestionStateProvider.notifier).state = AsyncData(response);
    } catch (e) {
      // Hata durumunu ayarla
      ref.read(askQuestionStateProvider.notifier).state = AsyncError(e, StackTrace.current);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(askQuestionStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Yıldızlara Sor')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TODO: Kalan soru kredisi bilgisini UserProvider'dan alıp burada göster.
            const Text('Kalan Soru Hakkı: 3'),
            const SizedBox(height: 20),
            TextField(
              controller: _questionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Aklındaki soruyu buraya yaz...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: state.isLoading ? null : _submitQuestion,
              text: state.isLoading ? 'Cevap Aranıyor...' : 'Cevabımı Al',
            ),
            const SizedBox(height: 30),
            Expanded(
              child: state.when(
                data: (response) {
                  if (response == null) {
                    return const Center(child: Text('Cevabınız burada görünecek.'));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sorduğun Soru:', style: Theme.of(context).textTheme.titleMedium),
                        Text(response.originalQuestion),
                        const SizedBox(height: 20),
                        Text('Yıldızların Cevabı:', style: Theme.of(context).textTheme.titleMedium),
                        Text(response.answer, style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Hata: ${err.toString()}', style: const TextStyle(color: Colors.red))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}