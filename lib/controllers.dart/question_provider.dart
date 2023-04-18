import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';

final questionsCont = StateNotifierProvider<QuestionsCont, List<Question>>(
    (ref) => QuestionsCont());

class QuestionsCont extends StateNotifier<List<Question>> {
  QuestionsCont() : super([]);

  void getQuestions(Operation operator, level) {
    try {
      state = QuizGen().questions(10, operator, level);
    } catch (e) {
      print("error $e");
    }
  }

  bool verifyAnswer(int ans, int? selected) => ans == selected;
}
