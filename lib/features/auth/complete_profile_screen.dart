import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmic_compass_app/common/widgets/primary_button.dart';
import 'package:cosmic_compass_app/models/user_enums.dart';
// TODO: Bu ekranın state'ini ve servisini yönetecek bir provider lazım.

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Doğum bilgisi için controller'lar
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  // ... (diğer tüm controller'lar)

  // Diğer kişisel bilgiler için state değişkenleri
  Gender? _selectedGender;
  RelationshipStatus? _selectedStatus;

  // TODO: Yüklenme durumu için bir state (isLoading)

  void _submitProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Backend'deki yeni PUT /users/me/complete-profile endpoint'ine istek at.
      // Başarılı olursa, AuthProvider'daki userProfile'ı invalidate ederek
      // AuthWrapper'ın yeniden çalışmasını ve kullanıcıyı HomeScreen'e yönlendirmesini tetikle.
      print('Profil tamamlanıyor ve kaydediliyor...');
    }
  }

  @override
  void dispose() {
    _yearController.dispose();
    // ... (tüm controller'ları dispose et)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Maceraya Başlamadan Son Bir Adım',
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sana özel yorumlar üretebilmemiz için bu bilgilere ihtiyacımız var.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Buraya, SynastryScreen için oluşturduğumuz
                  // PersonInfoForm widget'ının bir benzerini koyacağız.
                  // (Yıl, Ay, Gün, Saat, Dakika, Şehir, Ülke alanları)

                  const SizedBox(height: 20),
                  // SignUpScreen'den aldığımız Dropdown'lar
                  DropdownButtonFormField<Gender>(items: [], onChanged: (Gender? value) {  },/* ... */),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<RelationshipStatus>(items: [], onChanged: (RelationshipStatus? value) {  },/* ... */),

                  const SizedBox(height: 40),
                  PrimaryButton(
                    onPressed: _submitProfile,
                    text: 'Haritamı Oluştur ve Başla',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}