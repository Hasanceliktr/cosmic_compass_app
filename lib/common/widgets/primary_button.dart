
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Tıklama eylemi, null olabilir (buton pasif ise)

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector, Container gibi tıklama özelliği olmayan widget'lara
    // tıklama, sürükleme gibi eylemler eklememizi sağlar.
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56, // Figma'dan gelen yükseklik değeri
        width: double.infinity, // Butonun satırın tamamını kaplamasını sağlar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Figma'dan gelen kenar yuvarlaklığı
          gradient: AppColors.primaryGradient, // Merkezi temamızdan gelen gradyan
          boxShadow: [
            // Butona hafif bir derinlik ve parlama efekti ekleyelim
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.button, // Merkezi temamızdan gelen buton yazı stili
          ),
        ),
      ),
    );
  }
}