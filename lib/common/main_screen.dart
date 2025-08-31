import 'package:cosmic_compass_app/common/theme/app_colors.dart';
import 'package:cosmic_compass_app/features/community/community_screen.dart';
import 'package:cosmic_compass_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../features/features/profile_screen.dart';
import '../features/natalchart/natal_chart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Navigasyon çubuğuna tıklandığında gösterilecek ekranların listesi
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    NatalChartScreen(),
    CommunityScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Seçilen indekse göre ilgili ekranı body'de göster
      body: _screens.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.star), // Figma'daki ikona benzer
            label: 'Haritam',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCommentDots),
            label: 'Topluluk',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // --- STİL AYARLARI (Figma'ya uygun hale getirelim) ---
        backgroundColor: AppColors.cardBackground, // Arka plan rengi
        type: BottomNavigationBarType.fixed, // Butonların yerinde sabit kalmasını sağlar
        selectedItemColor: AppColors.accent, // Seçili ikonun rengi (altın sarısı)
        unselectedItemColor: AppColors.textSecondary, // Seçili olmayan ikonların rengi
        showSelectedLabels: false, // Sadece ikonlar görünsün, yazılar gizlensin
        showUnselectedLabels: false,
      ),
    );
  }
}