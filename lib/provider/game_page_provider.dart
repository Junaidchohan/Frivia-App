import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider with ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;
  final String difficulty;

  List? questions;
  int currentQuestionIndex = 0;
  int correctAccount = 0;

  // Add your state variables and methods here to manage game state
  BuildContext? context;
  GamePageProvider({required this.context, required this.difficulty}) {
    // Initialize any required data here
    dio.options.baseUrl = 'https://opentdb.com/';
    fetchQuestionFromAPI();
  }

  Future<void> fetchQuestionFromAPI() async {
    try {
      final response = await dio.get(
        'api.php',
        queryParameters: {
          'amount': maxQuestions,
          'type': 'boolean',
          'difficulty': difficulty,
        },
      );
      if (response.statusCode == 200) {
        questions = response.data['results'];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  Widget getCurrentQuestion() {
    if (questions != null && questions!.isNotEmpty) {
      final question = questions![currentQuestionIndex];
      return Text(
        question['question'],
        style: TextStyle(color: Colors.white, fontSize: 24),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        'Loading...',
        style: TextStyle(color: Colors.white, fontSize: 24),
        textAlign: TextAlign.center,
      );
    }
  }

  void answerQuestion(String answer) async {
    // Handle the answer logic here
    // For example, check if the answer is correct and update the score
    // Then fetch the next question or end the game if maxQuestions reached
    bool isCorrect =
        questions![currentQuestionIndex]['correct_answer'] == answer;
    correctAccount += isCorrect ? 1 : 0;
    currentQuestionIndex++;
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: Colors.white,
            size: 48,
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context!).pop();
      if (currentQuestionIndex >= maxQuestions) {
        endGame();
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> endGame() async {
    // Handle end game logic here
    // For example, show final score and reset the game state
    showDialog(
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text('Game Over!', style: TextStyle(color: Colors.white)),
          content: Text(
            "Score: $correctAccount / $maxQuestions",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context!).pop(); // Close the dialog
    currentQuestionIndex = 0;
    correctAccount = 0;
    notifyListeners();
  }
}
