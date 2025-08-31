// lib/models/natal_chart_data.dart

// Bu, gezegen, burç ve ev bilgisini tutan basit bir model.
class PlanetInfo {
  final String name;
  final String sign;
  final String house;

  PlanetInfo({required this.name, required this.sign, required this.house});
}

// Bu, tüm harita verisini içeren ana model.
class NatalChartData {
  final PlanetInfo sun;
  final PlanetInfo moon;
  final PlanetInfo ascendant;
  // TODO: Diğer gezegenleri de (Mercury, Venus vb.) buraya ekleyeceğiz.

  NatalChartData({required this.sun, required this.moon, required this.ascendant});
}