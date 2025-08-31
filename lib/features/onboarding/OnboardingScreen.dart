import 'package:flutter/material.dart';
import 'package:cosmic_compass_app/common/widgets/primary_button.dart';
import 'package:cosmic_compass_app/common/theme/app_colors.dart';
import 'package:cosmic_compass_app/models/onboarding_item.dart';
import '../auth/auth_gate_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Figma'daki metinlere ve resimlere göre bu listeyi dolduracağız.
  // Şimdilik yer tutucu (placeholder) metinler kullanalım.
  // Resimleri bir sonraki adımda ekleyeceğiz.
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      imagePath: 'assets/images/onboarding1.png', // Resimler henüz yok
      title: 'Kişisel Haritanı Keşfet',
      description: 'Doğum anının gökyüzü haritasını çıkararak potansiyellerini öğren.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/onboarding2.png',
      title: 'Günlük Rehberin',
      description: 'Anlık gezegen transitlerinin sana özel etkilerini her gün takip et.',
    ),
    OnboardingItem(
      imagePath: 'assets/images/onboarding3.png',
      title: 'Yıldızlara Soru Sor',
      description: 'Merak ettiğin konular hakkında yapay zeka destekli astrolojik cevaplar al.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _onboardingItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO: Resim buraya gelecek
                        const SizedBox(height: 60),
                        Text(item.title, style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(height: 20),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildPageIndicator(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PrimaryButton(
                text: _currentPage == _onboardingItems.length - 1 ? 'Başla' : 'İleri',
                onPressed: _onNext,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Sayfalar arasında geçiş yapan metot
  void _onNext() {
    if (_currentPage == _onboardingItems.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthGateScreen(),
        ),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Alttaki küçük noktaları (sayfa göstergesi) oluşturan widget
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardingItems.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.accent : AppColors.textSecondary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}