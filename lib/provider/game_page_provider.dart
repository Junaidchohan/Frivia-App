import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider with ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;

  List? questions;
  int currentQuestionIndex = 0;

  // Add your state variables and methods here to manage game state
  BuildContext? context;
  GamePageProvider({required this.context}) {
    // Initialize any required data here
    dio.options.baseUrl = 'https://opentdb.com/';
    fetchQuestionFromAPI();
  }

  Future<void> fetchQuestionFromAPI() async {
    try {
      final response = await dio.get(
        'api.php',
        queryParameters: {'amount': 1, 'type': 'boolean', 'difficulty': 'easy'},
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
}
