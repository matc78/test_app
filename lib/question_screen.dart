import 'dart:math';
import 'package:flutter/material.dart';
import 'player_input.dart';
import 'question.dart';

class QuestionScreen extends StatefulWidget {
  final List<Player> players;
  final String difficulty;
  final int numberOfTurns;

  QuestionScreen({required this.players, required this.difficulty, required this.numberOfTurns});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentIndex = 0;
  int _currentTurn = 1;
  late Player _currentPlayer;
  late Question _currentQuestion;
  late List<Question> _askedQuestions;
  late Map<Player, List<Question>> _questionsPerPlayer;

  @override
  void initState() {
    super.initState();
    _currentPlayer = widget.players[_currentIndex];
    _askedQuestions = [];
    _questionsPerPlayer = {for (var player in widget.players) player: []};
    _currentQuestion = _getRandomQuestion();
  }

  Question _getRandomQuestion() {
    List<Question> filteredQuestions = questions.where((question) {
      return (question.sex == _currentPlayer.sex || question.sex == 'neutral') &&
             question.difficulty == widget.difficulty &&
             !_questionsPerPlayer[_currentPlayer]!.contains(question) &&
             !_askedQuestions.contains(question);
    }).toList();

    if (filteredQuestions.isNotEmpty) {
      final randomIndex = Random().nextInt(filteredQuestions.length);
      return filteredQuestions[randomIndex];
    }
    return Question(text: 'No questions available for the selected criteria.', sex: 'neutral', difficulty: widget.difficulty);
  }

  void _nextQuestion() {
    setState(() {
      _questionsPerPlayer[_currentPlayer]!.add(_currentQuestion);
      _askedQuestions.add(_currentQuestion);

      if (_currentIndex == widget.players.length - 1) {
        _currentIndex = 0;
        _currentTurn++;
        if (_currentTurn > widget.numberOfTurns) {
          // Show end of game dialog
          _showEndDialog(context);
          return;
        }
        _askedQuestions.clear();
      } else {
        _currentIndex++;
      }

      _currentPlayer = widget.players[_currentIndex];
      _currentQuestion = _getRandomQuestion();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransitionScreen(
            currentPlayer: _currentPlayer,
            onContinue: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    });
  }

  void _showEndDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("C'est fini!"),
          content: Text("Le jeu est terminé. Merci d'avoir joué!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Le Jeu des Problèmes'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Question pour ${_currentPlayer.name}:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                _currentQuestion.text,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text('Next Question'),
              ),
            ],
          ),
        ),
      );
    }
  }

  class TransitionScreen extends StatelessWidget {
  final Player currentPlayer;
  final VoidCallback onContinue;

  TransitionScreen({required this.currentPlayer, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Donne le téléphone à ${currentPlayer.name}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onContinue,
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
