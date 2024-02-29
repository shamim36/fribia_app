import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestuion = 10;
  final  String difficultyLevel;

  List? questions;
  int _currentQuestionCount = 0;
  int _correctCount = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficultyLevel}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromAPI();
  }

  Future<void> _getQuestionFromAPI() async {
    // print(difficultyLevel);
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': _maxQuestuion,
        'difficulty': difficultyLevel,
        'type': 'boolean',
      },
    );
    var _data = jsonDecode(
      _response.toString(),
    );
    // print(_data);
    questions = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    questions![_currentQuestionCount]["question"] =
        '${_currentQuestionCount + 1}. ' +
            questions![_currentQuestionCount]["question"];
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _correctCount += isCorrect ? 1 : 0;
    _currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel_sharp,
            color: Colors.white,
          ),
        );
      },
    );

    // print(isCorrect ? "Correct!" : "InCorrect");
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestuion) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text(
            'End Game!!',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Score: $_correctCount/$_maxQuestuion',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    Navigator.pop(context);
    _currentQuestionCount = 0;
  }
}
