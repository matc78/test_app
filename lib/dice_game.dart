import 'package:flutter/material.dart';
import 'dart:math';

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> with SingleTickerProviderStateMixin {
  int _numberOfDice = 1;
  List<int> _diceResults = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(() {
        setState(() {
          if (_controller.isAnimating) {
            _diceResults = List<int>.generate(_numberOfDice, (index) => Random().nextInt(6) + 1);
          } else {
            _diceResults = List<int>.generate(_numberOfDice, (index) => Random().nextInt(6) + 1);
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de dés'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nombre de dés :',
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              value: _numberOfDice.toDouble(),
              min: 1,
              max: 6,
              divisions: 5,
              label: _numberOfDice.toString(),
              onChanged: (value) {
                setState(() {
                  _numberOfDice = value.toInt();
                });
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _rollDice,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Text(
                  'Lancer les dés',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildDiceDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceDisplay() {
    return _diceResults.isEmpty
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _diceResults.map((result) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * pi,
                      child: Image.asset(
                        'assets/images/dice-png-$result.png',
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
  }
}
