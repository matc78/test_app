import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import 'styles.dart';  // Importez le fichier des styles
import 'first_page.dart';
import 'second_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qnaisspmjjtxrofsuxsy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuYWlzc3Btamp0eHJvZnN1eHN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEwNDUzMTksImV4cCI6MjAzNjYyMTMxOX0.LyRTJ1aA-R_Uv0U92G3grmMt9G1iLlzSbXRHfne7prQ',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppStyles.appTheme,
      home: _checkAuth(),
    );
  }

  Widget _checkAuth() {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      return MyHomePage();
    } else {
      return LoginPage();
    }
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
              child: const Text('Clique ici'),
            ),
            ElevatedButton(
              style: AppStyles.elevatedButtonStyle,  // Utilisez le style de bouton défini
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: const Text('Pas la'),
            ),
          ],
        ),
      ),
    );
  }
}
