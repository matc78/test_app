import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Alcohol {
  final String name;
  final double degree; // Degré d'alcool

  Alcohol({required this.name, required this.degree});
}

class Drink {
  String alcoholName;
  double quantity; // en cl
  int shotsCount;
  int sipsCount;
  int fullCount;
  String mixer; // Boisson non alcoolisée obligatoire

  Drink({
    required this.alcoholName,
    required this.quantity,
    this.shotsCount = 0,
    this.sipsCount = 0,
    this.fullCount = 0,
    required this.mixer,
  });

  Map<String, dynamic> toJson() => {
        'alcoholName': alcoholName,
        'quantity': quantity,
        'shotsCount': shotsCount,
        'sipsCount': sipsCount,
        'fullCount': fullCount,
        'mixer': mixer,
      };

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        alcoholName: json['alcoholName'],
        quantity: json['quantity'],
        shotsCount: json['shotsCount'],
        sipsCount: json['sipsCount'],
        fullCount: json['fullCount'],
        mixer: json['mixer'],
      );
}

List<Alcohol> predefinedAlcohols = [
  Alcohol(name: 'Get27', degree: 21.0),
  Alcohol(name: 'Vodka', degree: 40.0),
  Alcohol(name: 'Jägermeister', degree: 35.0),
  Alcohol(name: 'Rhum blanc', degree: 40.0),
  Alcohol(name: 'Rhum brun', degree: 40.0),
  Alcohol(name: 'Captain Morgan', degree: 35.0),
  // Ajoutez d'autres alcools ici
];

List<String> predefinedMixers = ['Rien', 'Coca', 'Orangina', 'Fanta', 'Sprite', 'Perrier', 'Eau'];

class DrinkManagerPage extends StatefulWidget {
  @override
  _DrinkManagerPageState createState() => _DrinkManagerPageState();
}

class _DrinkManagerPageState extends State<DrinkManagerPage> {
  List<Drink> _drinks = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedAlcohol = predefinedAlcohols.first.name;
  String _selectedMixer = 'Coca';
  double _selectedQuantity = 0.0;
  int _gorgeesParVerre = 1;
  bool _showQuantityField = true;

  @override
  void initState() {
    super.initState();
    _loadDrinks();
  }

  void _loadDrinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _gorgeesParVerre = prefs.getInt('gorgeesParVerre') ?? 1;
      String? drinksJson = prefs.getString('drinks');
      if (drinksJson != null) {
        List<dynamic> drinksList = json.decode(drinksJson);
        _drinks = drinksList.map((drinkJson) => Drink.fromJson(json.decode(drinkJson))).toList();
      }
    });
  }

  void _saveDrinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> drinksList = _drinks.map((drink) => json.encode(drink.toJson())).toList();
    prefs.setString('drinks', json.encode(drinksList));
  }

  void _addDrink() {
    if (_formKey.currentState!.validate()) {
      bool exists = _drinks.any((drink) =>
          drink.alcoholName == _selectedAlcohol &&
          drink.mixer == _selectedMixer &&
          drink.quantity == _selectedQuantity);

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cette boisson existe déjà')),
        );
        return;
      }

      setState(() {
        _drinks.add(Drink(
          alcoholName: _selectedAlcohol,
          quantity: _selectedMixer == 'Rien' ? 0.0 : _selectedQuantity,
          mixer: _selectedMixer,
        ));
        _saveDrinks();
      });
      Navigator.of(context).pop();
    }
  }

  void _incrementShot(Drink drink) {
    setState(() {
      drink.shotsCount++;
      _saveDrinks();
    });
  }

  void _incrementSip(Drink drink) {
    setState(() {
      drink.sipsCount++;
      _saveDrinks();
    });
  }

  void _incrementFull(Drink drink) {
    setState(() {
      drink.fullCount++;
      _saveDrinks();
    });
  }

  void _showAddDrinkTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Type de boisson'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Choisissez le type de boisson que vous voulez ajouter:'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showAddDrinkDialog(isPure: true);
                    },
                    child: Text('Alcool PUR '),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showAddDrinkDialog(isPure: false);
                    },
                    child: Text('Mélange'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddDrinkDialog({required bool isPure}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une boisson'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Alcool'),
                  value: _selectedAlcohol,
                  items: predefinedAlcohols.map((Alcohol alcohol) {
                    return DropdownMenuItem<String>(
                      value: alcohol.name,
                      child: Text(alcohol.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAlcohol = newValue!;
                    });
                  },
                ),
                if (!isPure)
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Boisson non alcoolisée'),
                    value: _selectedMixer,
                    items: predefinedMixers.map((String mixer) {
                      return DropdownMenuItem<String>(
                        value: mixer,
                        child: Text(mixer),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMixer = newValue!;
                        _showQuantityField = newValue != 'Rien';
                      });
                    },
                  ),
                if (!isPure && _showQuantityField)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Quantité d\'alcool (en cl)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une quantité';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      double quantity = double.parse(value);
                      if (quantity > 25) {
                        return 'La quantité ne peut pas dépasser 25 cl';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _selectedQuantity = double.parse(value);
                      });
                    },
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ajouter'),
              onPressed: _addDrink,
            ),
          ],
        );
      },
    );
  }

  void _showTotal() {
    int totalShots = 0;
    int totalSips = 0;
    int totalFull = 0;
    double totalPureAlcohol = 0.0;
    double totalMixedAlcohol = 0.0;

    for (var drink in _drinks) {
      totalShots += drink.shotsCount;
      totalSips += drink.sipsCount;
      totalFull += drink.fullCount;

      if (drink.mixer == 'Rien') {
        totalPureAlcohol += drink.shotsCount * 2.0;
      } else {
        totalMixedAlcohol += drink.sipsCount * (drink.quantity / _gorgeesParVerre) + drink.fullCount * drink.quantity;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Total consommé'),
          content: Text(
              'Shots: $totalShots\nGorgées: $totalSips\nCul-sec: $totalFull\nQuantité alcool PUR bu : ${totalPureAlcohol.toStringAsFixed(1)} cl\nQuantité alcool dans mélanges bu : ${totalMixedAlcohol.toStringAsFixed(1)} cl'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Réinitialiser les boissons'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Combien de gorgées pour finir un verre de 25cl?'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gorgées par verre'),
                keyboardType: TextInputType.number,
                initialValue: _gorgeesParVerre.toString(),
                onChanged: (value) {
                  setState(() {
                    _gorgeesParVerre = int.parse(value);
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Réinitialiser'),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setInt('gorgeesParVerre', _gorgeesParVerre);
                  prefs.remove('drinks');
                  setState(() {
                    _drinks.clear();
                  });
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A boire tavernière'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _showResetDialog,
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: _showTotal,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _drinks.length,
        itemBuilder: (context, index) {
          Drink drink = _drinks[index];
          String drinkLabel = drink.alcoholName + (drink.mixer == 'Rien' ? ' pur' : ' avec ${drink.mixer} (${drink.quantity.toStringAsFixed(0)}cl/25cl)');
          return ListTile(
            title: Text(drinkLabel),
            subtitle: Text(
              drink.mixer == 'Rien'
                  ? '${drink.shotsCount} shots'
                  : '${drink.sipsCount} gorgées, ${drink.fullCount} cul-sec'
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (drink.mixer != 'Rien')
                  IconButton(
                    icon: Icon(Icons.local_drink),
                    onPressed: () => _incrementSip(drink),
                  ),
                if (drink.mixer != 'Rien')
                  IconButton(
                    icon: Icon(Icons.local_bar),
                    onPressed: () => _incrementFull(drink),
                  ),
                if (drink.mixer == 'Rien')
                  IconButton(
                    icon: Icon(Icons.liquor),
                    onPressed: () => _incrementShot(drink),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDrinkTypeDialog,
        tooltip: 'Ajouter une boisson',
        child: Icon(Icons.add),
      ),
    );
  }

}
