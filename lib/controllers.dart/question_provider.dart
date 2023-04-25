import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';

final questionsCont = StateNotifierProvider<QuestionsCont, List<Question>>(
    (ref) => QuestionsCont());

class QuestionsCont extends StateNotifier<List<Question>> {
  QuestionsCont() : super([]);

  List<Question>? getQuestions(Operation operator, level) {
    try {
      state = QuizGen().questions(10, operator, level).toList();
      return state;
    } catch (e) {
      return null;
    }
  }

  bool verifyAnswer(int ans, int? selected) => ans == selected;
}
