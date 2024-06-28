import 'package:flutter/material.dart';
import 'styles.dart';  // Importez le fichier des styles
import 'pyramide_w_cards.dart';
import 'roulette_game.dart';
import 'player_input.dart';  // Importez le fichier player_input.dart

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez un jeu', style: AppStyles.headingLarge),  // Utilisez les styles de texte définis
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PyramideWCards()),
                );
              },
              child: const Text('La Pyramide'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RouletteGame()),
                );
              },
              child: const Text('Roulette de BZ'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerInput()),
                );
              },
              child: const Text('Le Jeu des Problèmes'),
            ),
          ],
        ),
      ),
    );
  }
}
