class PersonInfo {
  final String name;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final String city;
  final String nation;

  // --- DÜZELTİLMİŞ CONSTRUCTOR ---
  // Bu, Dart'taki en standart ve en temiz constructor yazım şeklidir.
  // Tüm alanların "required" (zorunlu) olduğunu belirtir.
  PersonInfo({
    required this.name,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.city,
    required this.nation,
  });
  // -----------------------------

  // Backend'e göndermek için Map'e çeviren metot (Bu kısım zaten doğruydu).
  Map<String, dynamic> toJson() => {
    'name': name,
    'year': year,
    'month': month,
    'day': day,
    'hour': hour,
    'minute': minute,
    'city': city,
    'nation': nation,
  };
}