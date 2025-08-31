// lib/models/user_profile.dart

class UserProfile {
  final String id;
  final String name;
  final String email;
  final bool hasBirthInfo; // <-- YENİ ALAN
  final int questionCredits;
  // TODO: Backend'den 'questionCredits' gibi ek alanlar geldiğinde buraya ekleyeceğiz.

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.hasBirthInfo,
    required this.questionCredits
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      hasBirthInfo: json['hasBirthInfo'],
      questionCredits: json['questionCredits'],
    );
  }
}