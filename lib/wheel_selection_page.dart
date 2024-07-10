import 'package:flutter/material.dart';
import 'package:test_1/customize_wheel_page.dart';
import 'customize_options_page.dart';

class WheelSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisis bien'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeOptionsPage(option: 'donner'),
                  ),
                );
              },
              child: const Text('Ca donne fort'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeOptionsPage(option: 'prendre'),
                  ),
                );
              },
              child: const Text('Ca prend fort'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizeOptionsPage(option: 'random'),
                  ),
                );
              },
              child: const Text('Chai pas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomizeWheelPage(),
                  ),
                );
              },
              child: const Text('C\'est moi je choisis'),
            ),
          ],
        ),
      ),
    );
  }
}
