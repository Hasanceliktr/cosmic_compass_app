import 'package:flutter/material.dart';

import '../../home/widgets/person_info_controllers.dart';

class PersonInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final PersonInfoControllers controllers;

  const PersonInfoForm({
    super.key,
    required this.formKey,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controllers.nameController,
            decoration: const InputDecoration(labelText: 'Ad Soyad'),
            validator: (value) => (value == null || value.isEmpty) ? 'Bu alan zorunludur' : null,
          ),
          const SizedBox(height: 12),
          // Yıl, Ay, Gün için bir satır
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controllers.yearController,
                  decoration: const InputDecoration(labelText: 'Yıl'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.length != 4) ? 'YYYY' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: controllers.monthController,
                  decoration: const InputDecoration(labelText: 'Ay'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty) ? 'AA' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: controllers.dayController,
                  decoration: const InputDecoration(labelText: 'Gün'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty) ? 'GG' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Saat, Dakika için bir satır
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controllers.hourController,
                  decoration: const InputDecoration(labelText: 'Saat'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty) ? 'SS' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: controllers.minuteController,
                  decoration: const InputDecoration(labelText: 'Dakika'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty) ? 'DD' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Şehir, Ülke için bir satır
          Row(
            children: [
              Expanded(
                flex: 3, // Şehir alanı daha geniş olsun
                child: TextFormField(
                  controller: controllers.cityController,
                  decoration: const InputDecoration(labelText: 'Doğum Şehri'),
                  validator: (value) => (value == null || value.isEmpty) ? 'Bu alan zorunludur' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1, // Ülke kodu daha dar olsun
                child: TextFormField(
                  controller: controllers.nationController,
                  decoration: const InputDecoration(labelText: 'Ülke'),
                  validator: (value) => (value == null || value.length != 2) ? 'TR' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}