import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _shotsCount = 0;
  int _gorgeesCount = 0;
  int _culSecCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCounts();
  }

  void _loadCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _shotsCount = prefs.getInt('shotsCount') ?? 0;
      _gorgeesCount = prefs.getInt('gorgeesCount') ?? 0;
      _culSecCount = prefs.getInt('culSecCount') ?? 0;
    });
  }

  void _incrementCount(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (type == 'shot') {
        _shotsCount++;
        prefs.setInt('shotsCount', _shotsCount);
      } else if (type == 'gorgee') {
        _gorgeesCount++;
        prefs.setInt('gorgeesCount', _gorgeesCount);
      } else if (type == 'culSec') {
        _culSecCount++;
        prefs.setInt('culSecCount', _culSecCount);
      }
    });
  }

  void _resetCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('shotsCount');
    prefs.remove('gorgeesCount');
    prefs.remove('culSecCount');
    setState(() {
      _shotsCount = 0;
      _gorgeesCount = 0;
      _culSecCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compteur de Boissons'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCounts,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_shotsCount shots, $_gorgeesCount gorgées, $_culSecCount cul-sec',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _incrementCount('shot'),
              child: Text('Ajouter un shot'),
            ),
            ElevatedButton(
              onPressed: () => _incrementCount('gorgee'),
              child: Text('Ajouter une gorgée'),
            ),
            ElevatedButton(
              onPressed: () => _incrementCount('culSec'),
              child: Text('Ajouter un cul-sec'),
            ),
          ],
        ),
      ),
    );
  }
}
