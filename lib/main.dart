import 'package:flutter/material.dart';
import 'styles.dart';  // Importez le fichier des styles
import 'first_page.dart';
import 'second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppStyles.appTheme,  // Utilisez le thème défini dans styles.dart
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShiFuShot', style: AppStyles.headingLarge),  // Utilisez les styles de texte définis
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
                  MaterialPageRoute(builder: (context) => FirstPage()),
                );
              },
              child: const Text('I have cards'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: const Text('I have no cards'),
            ),
          ],
        ),
      ),
    );
  }
}
