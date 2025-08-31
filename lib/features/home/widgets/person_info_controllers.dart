import 'package:flutter/material.dart';
import 'package:cosmic_compass_app/models/person_info.dart';

// Bu sınıf, bir kişinin formundaki tüm TextEditingController'ları
// bir arada tutar ve yönetir.
class PersonInfoControllers {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final dayController = TextEditingController();
  final hourController = TextEditingController();
  final minuteController = TextEditingController();
  final cityController = TextEditingController();
  final nationController = TextEditingController();

  // Controller'lardaki veriyi, backend'e göndereceğimiz PersonInfo modeline dönüştürür.
  PersonInfo toPersonInfo() {
    return PersonInfo(
      name: nameController.text,
      year: int.parse(yearController.text),
      month: int.parse(monthController.text),
      day: int.parse(dayController.text),
      hour: int.parse(hourController.text),
      minute: int.parse(minuteController.text),
      city: cityController.text,
      nation: nationController.text,
    );
  }

  // Bu controller'ların dispose edilmesi (kaynakları serbest bırakması) gerekir.
  void dispose() {
    nameController.dispose();
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    hourController.dispose();
    minuteController.dispose();
    cityController.dispose();
    nationController.dispose();
  }
}