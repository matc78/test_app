import 'dart:math';
import 'package:flutter/material.dart';

class ClockGame extends StatefulWidget {
  @override
  _ClockGameState createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  int _shotsCount = 0;
  int _gorgeesCount = 0;

  void _showChoiceDialog(String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pour $label'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Choisissez une couleur:'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _handleChoice(label, 'Rouge');
                    },
                    child: const Text('Rouge'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleChoice(label, 'Noir');
                    },
                    child: const Text('Noir'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleChoice(String label, String choice) {
    Navigator.of(context).pop(); // Fermer la boîte de dialogue de choix
    bool isCorrect = Random().nextBool(); // Générer aléatoirement le résultat
    String message;
    Color dialogColor;


    int shots = _shotsCount;
    int gorgees = _gorgeesCount;

    if (isCorrect) {
      message = 'Bravo, vous avez gagné!';
      dialogColor = Colors.yellow;
      setState(() {
        if (label == '1 shot') {
          _shotsCount++;
        } else if (label == '5 gorgées') {
          _gorgeesCount += 5;
        } else if (label == '3 gorgées') {
          _gorgeesCount += 3;
        } else if (label == '2 gorgées') {
          _gorgeesCount += 2;
        }
      });
    } else {
      // Ajouter la boisson du cercle actuel au compteur
      if (label == '1 shot') {
        shots++;
      } else if (label == '5 gorgées') {
        gorgees += 5;
      } else if (label == '3 gorgées') {
        gorgees += 3;
      } else if (label == '2 gorgées') {
        gorgees += 2;
      }

      message = 'Perdu, vous allez boire $shots shots et $gorgees gorgées!';
      dialogColor = Colors.red;
      setState(() {
        _shotsCount = 0;
        _gorgeesCount = 0;
      });
    }

    _showResultDialog(message, dialogColor);
  }

  void _showResultDialog(String message, Color dialogColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Résultat',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: dialogColor,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue de résultat
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCircle(String label, double size) {
    return GestureDetector(
      onTap: () => _showChoiceDialog(label),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('L\'Horloge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_shotsCount shots et $_gorgeesCount gorgées',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildCircle('1 shot', 150.0),
            const SizedBox(height: 20),
            _buildCircle('5 gorgées', 120.0),
            const SizedBox(height: 20),
            _buildCircle('3 gorgées', 100.0),
            const SizedBox(height: 20),
            _buildCircle('2 gorgées', 80.0),
          ],
        ),
      ),
    );
  }
}
