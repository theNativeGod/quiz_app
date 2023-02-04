import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app/pages/home_page.dart';

import '../models/question.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  List? questions;

  int currentIndex = 0;

  Question? question;

  int _currentScore = 0;

  String? difficulty, type;

  BuildContext context;

  GamePageProvider({
    required this.context,
    this.difficulty = null,
    this.type = null,
  }) {
    _dio.options.baseUrl = "http://opentdb.com/api.php";
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    try {
      var _response = await _dio.get(
        '',
        queryParameters: {
          'amount': 10,
          'category': 0,
          'type': this.type,
          'difficulty': this.difficulty,
        },
      );

      var _data = jsonDecode(_response.toString());
      questions = _data['results'];
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Center(
                child: Text(
                  error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
    }

    notifyListeners();
  }

  Question getQuestion() {
    question = Question(
      questionText: questions![currentIndex]["question"] as String,
      category: questions![currentIndex]["category"] as String,
      type: questions![currentIndex]["type"] as String,
      difficulty: questions![currentIndex]["difficulty"] as String,
      correctAnswer: questions![currentIndex]["correct_answer"] as String,
      options: questions![currentIndex]["incorrect_answers"],
    );
    return question!;
  }

  void checkAnswerAndAddScore(String answer) async {
    bool isCorrect = question!.correctAnswer == answer;
    _currentScore = isCorrect ? _currentScore + 1 : _currentScore - 1;
    currentIndex++;

    if (currentIndex >= _maxQuestions) {
      showResultAndQuitGame();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            return AlertDialog(
              backgroundColor: isCorrect ? Colors.green : Colors.red,
              title: Icon(
                isCorrect ? Icons.check_circle : Icons.cancel_sharp,
                color: Colors.white,
              ),
            );
          });
      await Future.delayed(
        const Duration(seconds: 1),
      ).then((_) {
        Navigator.pop(context);
        notifyListeners();
      });
    }
  }

  void showResultAndQuitGame() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'You Made It!\nScore: $_currentScore/10',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
