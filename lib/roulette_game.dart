import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';

class RouletteGame extends StatefulWidget {
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
    int result = Random().nextInt(8); // Suppose que vous avez 8 sections sur la roulette
    selected.add(result);
    lastResult = result;
  }

  void _showResultDialog(BuildContext context, int result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ET BAM!"),
          content: Text("Prend ou donne ${_getPrize(result)}!"),
          actions: <Widget>[
            TextButton(
              child: Text("J'ai capté"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getPrize(int index) {
    List<String> prizes = [
      '1 shot',
      '2 shots',
      '1 gorgée',
      '3 gorgées',
      '1 shot',
      '2 shots',
      '3 gorgées',
      'Cul-sec'
    ];
    return prizes[index];
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
              width: 300, // Définir la largeur de la roue
              height: 300, // Définir la hauteur de la roue
              child: FortuneWheel(
                selected: selected.stream,
                onAnimationEnd: () {
                  if (lastResult != null) {
                    _showResultDialog(context, lastResult!);
                    lastResult = null;
                  }
                },
                items: const [
                  FortuneItem(child: Text('1 shot')),
                  FortuneItem(child: Text('2 shots')),
                  FortuneItem(child: Text('1 gorgée')),
                  FortuneItem(child: Text('3 gorgées')),
                  FortuneItem(child: Text('1 shot')),
                  FortuneItem(child: Text('2 shots')),
                  FortuneItem(child: Text('3 gorgées')),
                  FortuneItem(child: Text('Cul-sec')),
                ],
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('Spin that shit'),
            ),
          ],
        ),
      ),
    );
  }
}
