import 'package:flutter/material.dart';
import 'package:test_1/card_drawer_game.dart';
import 'package:test_1/dice_game.dart';
import 'styles.dart';  // Importez le fichier des styles
import 'pyramide_w_cards.dart';
import 'roulette_game/wheel_selection_page.dart'; // Assurez-vous d'importer la page de sélection
import 'probleme_game/player_input.dart';  // Importez le fichier player_input.dart
import 'clock_game.dart'; // Importez le nouveau fichier du jeu


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
                  MaterialPageRoute(builder: (context) => WheelSelectionPage()), // Naviguez vers la page de sélection
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
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardDrawerGame()),
                );
              },
              child: const Text('Tireur de Carte Aléatoire'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiceGame()),
                );
              },
              child: const Text('Jeu de Dés'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClockGame()),
                );
              },
              child: const Text('L\'Horloge'),
            ),
          ],
        ),
      ),
    );
  }
}


