import 'package:flutter/material.dart';

class AppStyles {
  // Couleurs
  static const Color primaryColor = Colors.brown;
  static const Color accentColor = Colors.amber;
  static const Color backgroundColor = Color.fromARGB(255, 220, 201, 193);

  // Text Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );


  // Button Styles
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: primaryColor,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );

  // Thème de l'application
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,  // Définir la couleur d'arrière-plan globale des Scaffold
    textTheme: TextTheme(
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      bodyLarge: bodyText,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
      primary: primaryColor,
      surface: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor, // Change la couleur de fond de la barre d'application
      titleTextStyle: TextStyle(
        color: Colors.white, // Change la couleur du texte du titre de la barre d'application en blanc
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  
  static get headingLarge => null;
  
  static get headingMedium => null;
}
