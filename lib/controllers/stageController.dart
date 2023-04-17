import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/controllers/levelNotifier.dart';
import 'package:kiddy_maths/controllers/operator_state_notifier.dart';
import 'package:kiddy_maths/controllers/questionNotifier.dart';
import 'package:kiddy_maths/controllers/questions_state_notifier.dart';
import 'package:kiddy_maths/controllers/scoreNotifier.dart';
import 'package:kiddy_maths/controllers/stages_notifier.dart';

import '../utils/local_storage.dart';

final openStages = FutureProvider<int>((ref) async {
  var operator = ref.read(operation);
  var state = await LocalStorage.retrieve(operator.name);
  print("operator is $operator and stage is $state");
  return state;
});

var operation = StateNotifierProvider<OperatorNotifier, Operation>((ref) {
  return OperatorNotifier();
});
var level = StateNotifierProvider<LevelNotifier, int>((ref) {
  return LevelNotifier();
});

var questionsController =
    StateNotifierProvider<QuestionNotifier, List<Question>>((ref) {
  return QuestionNotifier();
});

var questionCount = StateNotifierProvider<QuestionCountNotifier, int>(
    (ref) => QuestionCountNotifier());

var scoreController =
    StateNotifierProvider<ScoreNotifier, int>((ref) => ScoreNotifier());
