import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';

class RouletteGame extends StatefulWidget {
  final String option;
  final List<String> options;

  RouletteGame({required this.option, required this.options});

  @override
  _RouletteGameState createState() => _RouletteGameState();
}

class _RouletteGameState extends State<RouletteGame> {
  StreamController<int> selected = StreamController<int>();
  int? lastResult;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _spinWheel() {
    int result = Random().nextInt(widget.options.length); // Utilisation de la longueur de la liste des options
    selected.add(result);
    lastResult = result;
  }

  void _showResultDialog(BuildContext context, int result) {
    String action;
    if (widget.option == 'donner') {
      action = 'Suuuuuuuuuuuu, Donne';
    } else if (widget.option == 'prendre') {
      action = 'Cheh, Prend';
    } else if (widget.option == 'random') {
      action = (Random().nextBool()) ? 'Suuuuuuuuuuu, Donne' : 'Cheh, Prend';
    } else {
      action = ''; // Pour personnalisé, juste montrer l'option sans action
    }

    String message = (action.isNotEmpty) ? "$action ${widget.options[result]}!" : "${widget.options[result]}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ET BAM!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("J'ai capté"),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: const Text('Roulette de BZ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: const Offset(0, 10), // changes position of shadow
                  ),
                ],
              ),
              child: FortuneWheel(
                selected: selected.stream,
                onAnimationEnd: () {
                  if (lastResult != null) {
                    _showResultDialog(context, lastResult!);
                    lastResult = null;
                  }
                },
                items: widget.options.map((option) => FortuneItem(child: Text(option))).toList(),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _spinWheel,
              child: const Text('Spin that shit'),
            ),
          ],
        ),
      ),
    );
  }
}
