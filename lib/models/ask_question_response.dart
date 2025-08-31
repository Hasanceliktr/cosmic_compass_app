// lib/models/ask_question_response.dart

class AskQuestionResponse {
  final String originalQuestion;
  final String answer;

  AskQuestionResponse({required this.originalQuestion, required this.answer});

  factory AskQuestionResponse.fromJson(Map<String, dynamic> json) {
    return AskQuestionResponse(
      originalQuestion: json['originalQuestion'],
      answer: json['answer'],
    );
  }
}