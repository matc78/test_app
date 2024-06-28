import 'package:flutter/material.dart';

class PyramideWCards extends StatefulWidget {
  @override
  _PyramideWCardsState createState() => _PyramideWCardsState();
}

class _PyramideWCardsState extends State<PyramideWCards> {
  List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('La Pyramide'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
           SizedBox(
            width: double.infinity,
            height: 200.0, // Définir la hauteur souhaitée
            child: Image.asset(
              'assets/images/pyramide.png',
              fit: BoxFit.cover, // Ajuster l'image à l'espace donné
            ),
          ),
          const SizedBox(height: 16.0),
          const Section(
            title: 'Contexte',
            content: 'La Pyramide est un jeu qui se joue à plusieurs et qui a pour but de se donner à boire en se faisant des ennemis.',
          ),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = !_data[index].isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      item.headerValue,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                body: ListTile(
                  title: Text(
                    item.expandedValue,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String content;

  const Section({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
      headerValue: 'Démarrage',
      expandedValue: 'Pour démarrer le jeu, chaque joueur reçoit un certain nombre de cartes et la pyramide est construite au centre de la table.',
    ),
    Item(
      headerValue: 'Jeux',
      expandedValue: 'Le jeu se déroule en plusieurs tours où les joueurs doivent suivre des règles spécifiques pour chaque niveau de la pyramide.',
    ),
    Item(
      headerValue: 'Fin du jeu',
      expandedValue: 'Le jeu se termine lorsque toutes les cartes de la pyramide ont été retournées et que les joueurs ont suivi toutes les règles.',
    ),
  ];
}
