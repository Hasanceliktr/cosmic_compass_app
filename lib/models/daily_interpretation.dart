// lib/models/daily_interpretation.dart

class DailyInterpretation {
  final String date; // LocalDate'i şimdilik String olarak alalım
  final String title;
  final String interpretationText;
  final String relevantPlanet;

  DailyInterpretation({
    required this.date,
    required this.title,
    required this.interpretationText,
    required this.relevantPlanet,
  });

  factory DailyInterpretation.fromJson(Map<String, dynamic> json) {
    return DailyInterpretation(
      date: json['date'],
      title: json['title'],
      interpretationText: json['interpretationText'],
      relevantPlanet: json['relevantPlanet'],
    );
  }
}