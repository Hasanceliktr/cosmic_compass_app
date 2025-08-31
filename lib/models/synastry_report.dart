// lib/models/synastry_report.dart

class SynastryReport {
  final String title;
  final String summary;
  final double relationshipScore;

  SynastryReport({required this.title, required this.summary, required this.relationshipScore});

  factory SynastryReport.fromJson(Map<String, dynamic> json) {
    return SynastryReport(
      title: json['title'],
      summary: json['summary'],
      relationshipScore: (json['relationshipScore'] as num).toDouble(),
    );
  }
}