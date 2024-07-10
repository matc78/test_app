import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  List<int> _diceResults = [1, 1]; // Initial dice values
  bool _rolling = false;
  Timer? _timer;
  int _numberOfDice = 2;
  List<double> _rotations = [0, 0, 0];
  List<bool> _clockwise = [true, false, true];
  List<double> _rotationSpeeds = [0.0, 0.0, 0.0];

  void _rollDice() {
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _rolling = true;
      // Randomly choose the direction and speed of rotation for each die
      _clockwise = List.generate(_numberOfDice, (index) => _random.nextBool());
      _rotationSpeeds = List.generate(_numberOfDice, (index) => 0.1 + _random.nextDouble() * 0.3);
    });

    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        _diceResults = List.generate(_numberOfDice, (index) => 1 + _random.nextInt(6));
        _rotations = List.generate(
            _numberOfDice, (index) => _clockwise[index] ? _rotations[index] + _rotationSpeeds[index] : _rotations[index] - _rotationSpeeds[index]);
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_timer != null) {
        _timer!.cancel();
      }
      setState(() {
        _diceResults = List.generate(_numberOfDice, (index) => 1 + _random.nextInt(6));
        _rotations = List.generate(_numberOfDice, (index) => 0.0); // Reset rotations
        _rolling = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Roller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_numberOfDice == 3)
              Transform.rotate(
                angle: _rotations[2],
                child: ClipOval(
                  child: Container(
                    color: Colors.white, // Background color for the dice
                    padding: const EdgeInsets.all(24),
                    child: Image.asset(
                      'assets/images/dice-png-${_diceResults[2]}.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _diceResults.take(2).map((result) {
                int index = _diceResults.indexOf(result);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle: _rotations[index],
                    child: ClipOval(
                      child: Container(
                        color: Colors.white, // Background color for the dice
                        padding: const EdgeInsets.all(24),
                        child: Image.asset(
                          'assets/images/dice-png-$result.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              'Nombre de dés:',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<int>(
              value: _numberOfDice,
              items: [1, 2, 3].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _numberOfDice = value!;
                  _diceResults = List.generate(_numberOfDice, (index) => 1); // Reset dice results when number changes
                  _rotations = List.generate(_numberOfDice, (index) => 0.0);
                  _rotationSpeeds = List.generate(_numberOfDice, (index) => 0.0);
                  _clockwise = List.generate(_numberOfDice, (index) => true);
                });
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _rolling ? null : _rollDice,
              child: const Text(
                'Roll Dice',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
