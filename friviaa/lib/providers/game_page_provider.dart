import "dart:convert";

import "package:flutter/material.dart";
import "package:dio/dio.dart";

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  final String difficulty;

  List? questions;
  int _currentQuestionCount = 0;
  int _correctAnswer = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.difficulty}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromAPI();
  }

  Future<void> _getQuestionFromAPI() async {
    var _response = await _dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': difficulty,
      },
    );
    var _data = jsonDecode(
      _response.toString(),
    );
    questions = _data['results'];
    print(_data);
    notifyListeners();
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]['correct_answer'] == _answer;
    _currentQuestionCount++;
    if (isCorrect) {
      _correctAnswer++;
    }
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
    await Future.delayed(
      Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            'END GAME',
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          content: Text('Score: $_correctAnswer/$_maxQuestions'),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Navigator.pop(context);
    // Navigator.pop(context);
  }
}
