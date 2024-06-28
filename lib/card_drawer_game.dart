import 'package:flutter/material.dart';
import 'dart:math';

class CardDrawerGame extends StatefulWidget {
  @override
  _CardDrawerGameState createState() => _CardDrawerGameState();
}

class _CardDrawerGameState extends State<CardDrawerGame> {
  final List<String> _cards = [
    'As de ♥️', '2 de ♥️', '3 de ♥️', '4 de ♥️', '5 de ♥️', '6 de ♥️', '7 de ♥️', '8 de ♥️', '9 de ♥️', '10 de ♥️', 'Valet de ♥️', 'Dame de ♥️', 'Roi de ♥️',
    'As de ♦️', '2 de ♦️', '3 de ♦️', '4 de ♦️', '5 de ♦️', '6 de ♦️', '7 de ♦️', '8 de ♦️', '9 de ♦️', '10 de ♦️', 'Valet de ♦️', 'Dame de ♦️', 'Roi de ♦️',
    'As de ♣️', '2 de ♣️', '3 de ♣️', '4 de ♣️', '5 de ♣️', '6 de ♣️', '7 de ♣️', '8 de ♣️', '9 de ♣️', '10 de ♣️', 'Valet de ♣️', 'Dame de ♣️', 'Roi de ♣️',
    'As de ♠️', '2 de ♠️', '3 de ♠️', '4 de ♠️', '5 de ♠️', '6 de ♠️', '7 de ♠️', '8 de ♠️', '9 de ♠️', '10 de ♠️', 'Valet de ♠️', 'Dame de ♠️', 'Roi de ♠️',
  ];

  List<String> _drawnCards = [];
  int _numCardsToDraw = 1;

  void _drawCards() {
    final random = Random();
    setState(() {
      _drawnCards = List.generate(_numCardsToDraw, (_) => _cards[random.nextInt(_cards.length)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tireur de Carte Aléatoire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nombre de cartes à tirer:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownButton<int>(
              value: _numCardsToDraw,
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _numCardsToDraw = value!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _drawCards,
              child: Text('Tirer les Cartes'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _drawnCards.length,
                itemBuilder: (context, index) {
                  String card = _drawnCards[index];
                  bool isRed = card.contains('♥️') || card.contains('♦️');
                  return Text(
                    card,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isRed ? Colors.red : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
