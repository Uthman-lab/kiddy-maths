import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';

class QuestionNotifier extends StateNotifier<List<Question>> {
  QuestionNotifier() : super([]);
  List<Question> questions = [];

  checkStatus(int openStage, int level) {
    if (openStage >= level) return true;
    return false;
  }

  List<Question> getQuestions(
    int level,
    Operation operation,
    int openStage,
  ) {
    if (checkStatus(openStage, level)) {
      state = QuizGen().questions(10, operation, level);
    }

    return state;
  }

  void reset() {
    state = [];
  }
}
