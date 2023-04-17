import 'dart:collection';
import 'dart:ffi';
import 'dart:math';

class QuizGen {
  int rounds = 5;

  List<Question> questions(int num, Operation operation, int level) {
    List<Question> questions = [];

    // make sure number does not go beyound 10, to prevent the loop from running till infinity
    if (num > 10) num = 10;
    while (questions.length < num) {
      if (operation == Operation.add) {
        var q = Addition(
            getRandomNumber(level: level), getRandomNumber(level: level));
        _addUniqueEntry(questions, q);
      } else if (operation == Operation.sub) {
        var a = getRandomNumber(level: level);
        var b = getRandomNumber(level: level);
        var q = Subtraction(max(a, b), min(a, b));
        _addUniqueEntry(questions, q);
      } else if (operation == Operation.multiply) {
        var q = Multiplication(
            getRandomNumber(level: level), getRandomNumber(level: level));
        _addUniqueEntry(questions, q);
      }
    }

    return questions;
  }

  _addUniqueEntry(List<Question> questions, q) {
    if (!isFound(questions, q)) questions.add(q);
  }

  int getRandomNumber({int level = 1}) {
    int start = rounds * (level - 1);
    int next = rounds * level;
    Random random = Random();
    return start + random.nextInt(next);
  }

  bool isFound(List<Question> list, Question q) {
    for (var elem in list) {
      if (elem.match(q)) return true;
    }
    return false;
  }
}

enum Operation { add, sub, multiply }

abstract class Question {
  int first;
  int second;
  late String sign;
  late int answer;
  Question(
    this.first,
    this.second,
  );

  int subtract() {
    if (first > second) return first - second;
    return second - first;
  }

  bool match(Question other) {
    if (other.second == second && other.first == first) return true;
    return false;
  }
}

class Multiplication extends Question {
  Multiplication(
    super.first,
    super.second,
  ) {
    super.answer = first * second;
    super.sign = "*";
  }
}

class Addition extends Question {
  Addition(
    super.first,
    super.second,
  ) {
    super.answer = first + second;
    super.sign = "+";
  }
}

class Subtraction extends Question {
  Subtraction(
    super.first,
    super.second,
  ) {
    if (first > second) {
      answer = first - second;
    } else {
      answer = second - first;
    }
    super.sign = "-";
  }
}
