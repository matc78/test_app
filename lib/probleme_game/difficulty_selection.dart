import 'package:flutter/material.dart';
import 'player_input.dart';
import 'question_screen.dart';

class DifficultySelection extends StatefulWidget {
  final List<Player> players;

  DifficultySelection({required this.players});

  @override
  _DifficultySelectionState createState() => _DifficultySelectionState();
}

class _DifficultySelectionState extends State<DifficultySelection> {
  String? selectedDifficulty;
  int? selectedTurns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionnez la difficulté et le nombre de tours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sélectionnez la difficulté:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              items: ['easy', 'extreme']
                  .map((difficulty) => DropdownMenuItem<String>(
                        value: difficulty,
                        child: Text(difficulty),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Difficulté',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Sélectionnez le nombre de tours:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              items: [1, 2, 3]
                  .map((turns) => DropdownMenuItem<int>(
                        value: turns,
                        child: Text('$turns'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTurns = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nombre de tours',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (selectedDifficulty != null && selectedTurns != null) {
                  // Navigate to the question screen with the selected difficulty and number of turns
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(
                        players: widget.players,
                        difficulty: selectedDifficulty!,
                        numberOfTurns: selectedTurns!,
                      ),
                    ),
                  );
                } else {
                  // Show an error if the user hasn't selected both difficulty and number of turns
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez sélectionner une difficulté et un nombre de tours'),
                    ),
                  );
                }
              },
              child: Text('Commencer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
