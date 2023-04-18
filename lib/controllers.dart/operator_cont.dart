import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddy_maths/business_logic/quiz_generator.dart';
import 'package:kiddy_maths/screens/select_operator_screen.dart';

final operatorCont = StateProvider<Operator?>((ref) => null);
