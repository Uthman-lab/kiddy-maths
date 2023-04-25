import 'dart:math';

class QuizGen {
  int rounds = 5;

  Set<Question> questions(int num, Operation operation, int level) {
    Set<Question> questions = {};

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

  _addUniqueEntry(Set<Question> questions, q) {
    if (!isFound(questions, q)) questions.add(q);
  }

  int getRandomNumber({int level = 1}) {
    int start = rounds * (level - 1);
    int next = rounds * level;
    Random random = Random();
    return start + random.nextInt(next);
  }

  bool isFound(Set<Question> set, Question q) {
    return set.contains(q);
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

// import 'dart:math';

// // Factory pattern to generate questions
// abstract class QuestionFactory {
//   Question create(int first, int second);
// }

// class AdditionFactory implements QuestionFactory {
//   @override
//   Question create(int first, int second) {
//     return Addition(first, second);
//   }
// }

// class SubtractionFactory implements QuestionFactory {
//   @override
//   Question create(int first, int second) {
//     return Subtraction(first, second);
//   }
// }

// class MultiplicationFactory implements QuestionFactory {
//   @override
//   Question create(int first, int second) {
//     return Multiplication(first, second);
//   }
// }

// // Strategy pattern to handle different operations
// abstract class Operation {
//   QuestionFactory getFactory();
// }

// class AddOperation implements Operation {
//   @override
//   QuestionFactory getFactory() {
//     return AdditionFactory();
//   }
// }

// class SubOperation implements Operation {
//   @override
//   QuestionFactory getFactory() {
//     return SubtractionFactory();
//   }
// }

// class MultiplyOperation implements Operation {
//   @override
//   QuestionFactory getFactory() {
//     return MultiplicationFactory();
//   }
// }

// // Question interface
// abstract class Question {
//   int first;
//   int second;
//   late String sign;
//   late int answer;
//   Question(this.first, this.second);
//   int subtract() {
//     if (first > second) return first - second;
//     return second - first;
//   }

//   bool match(Question other) {
//     if (other.second == second && other.first == first) return true;
//     return false;
//   }

//   @override
//   String toString() {
//     return '$first $sign $second = $answer';
//   }
// }

// // Question implementations
// class Addition extends Question {
//   Addition(super.first, super.second) {
//     answer = first + second;
//     sign = '+';
//   }
// }

// class A extends Question {
//   A(super.first, super.second);
// }

// class Subtraction extends Question {
//   Subtraction(super.first, super.second) {
//     answer = subtract();
//     sign = '-';
//   }
// }

// class Multiplication extends Question {
//   Multiplication(super.first, super.second) {
//     answer = first * second;
//     sign = '*';
//   }
// }

// class QuizGen {
//   int rounds = 5;

//   Set<Question> questions(int num, Operation operation, int level) {
//     Set<Question> questions = {};

//     // make sure number does not go beyond 10, to prevent the loop from running indefinitely
//     if (num > 10) num = 10;

//     var factory = operation.getFactory();

//     while (questions.length < num) {
//       var q = factory.create(
//         getRandomNumber(level: level),
//         getRandomNumber(level: level),
//       );
//       _addUniqueEntry(questions, q);
//     }

//     return questions;
//   }

//   _addUniqueEntry(Set<Question> questions, Question q) {
//     if (!isFound(questions, q)) questions.add(q);
//   }

//   int getRandomNumber({int level = 1}) {
//     int start = rounds * (level - 1);
//     int next = rounds * level;
//     Random random = Random();
//     return start + random.nextInt(next);
//   }

//   bool isFound(Set<Question> set, Question q) {
//     return set.contains(q);
//   }
// }

// void main() {
//   var quizGen = QuizGen();
//   var questions = quizGen.questions(10, AddOperation(), 1);
//   questions.forEach((question) => print(question.toString()));
// }
