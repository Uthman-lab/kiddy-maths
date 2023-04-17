import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';

class OperatorNotifier extends StateNotifier<Operation> {
  OperatorNotifier() : super(Operation.add);

  void selectOperator(Operation operator) {
    state = operator;
  }

  String getName() {
    return state.name;
  }
}
