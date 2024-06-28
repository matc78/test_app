import 'package:flutter/material.dart';
import 'difficulty_selection.dart';

class Player {
  final String name;
  final String sex; // 'male' or 'female'

  Player({required this.name, required this.sex});
}

class PlayerInput extends StatefulWidget {
  @override
  _PlayerInputState createState() => _PlayerInputState();
}

class _PlayerInputState extends State<PlayerInput> {
  final List<Player> _players = [];
  final TextEditingController _nameController = TextEditingController();
  String _selectedSex = 'male';

  void _addPlayer() {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      setState(() {
        _players.add(Player(name: name, sex: _selectedSex));
        _nameController.clear();
      });
    }
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  void _startGame() {
    if (_players.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DifficultySelection(players: _players),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrez les joueurs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom du joueur'),
            ),
            DropdownButton<String>(
              value: _selectedSex,
              items: [
                DropdownMenuItem(value: 'male', child: Text('Homme')),
                DropdownMenuItem(value: 'female', child: Text('Femme')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSex = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addPlayer,
              child: Text('Ajouter le joueur'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _players.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_players[index].name),
                    subtitle: Text(_players[index].sex == 'male' ? 'Homme' : 'Femme'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removePlayer(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _startGame,
              child: Text('Commencer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}
