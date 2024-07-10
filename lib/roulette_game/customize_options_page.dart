import 'package:flutter/material.dart';
import 'roulette_game.dart';

class CustomizeOptionsPage extends StatefulWidget {
  final String option;
  const CustomizeOptionsPage({required this.option});

  @override
  _CustomizeOptionsPageState createState() => _CustomizeOptionsPageState();
}

class _CustomizeOptionsPageState extends State<CustomizeOptionsPage> {
  final List<TextEditingController> _numberControllers = [];
  final List<String> _selectedTypes = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeDefaultOptions();
  }

  void _initializeDefaultOptions() {
    // Ajoute les options par défaut
    _numberControllers.add(TextEditingController(text: '2'));
    _selectedTypes.add('shot');
    _numberControllers.add(TextEditingController(text: '1'));
    _selectedTypes.add('gorgée');
    _numberControllers.add(TextEditingController(text: '3'));
    _selectedTypes.add('gorgée');
    _numberControllers.add(TextEditingController(text: '1'));
    _selectedTypes.add('shot');
    _numberControllers.add(TextEditingController(text: '4'));
    _selectedTypes.add('gorgée');
    _numberControllers.add(TextEditingController(text: '1'));
    _selectedTypes.add('cul-sec');
  }

  void _addOption() {
    setState(() {
      _numberControllers.add(TextEditingController());
      _selectedTypes.add('shot');
    });
  }

  void _removeOption(int index) {
    setState(() {
      _numberControllers.removeAt(index);
      _selectedTypes.removeAt(index);
    });
  }

  void _startGame() {
    List<String> options = [];
    for (int i = 0; i < _numberControllers.length; i++) {
      String number = _numberControllers[i].text;
      String type = _selectedTypes[i];
      options.add('$number $type');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RouletteGame(
          option: widget.option,
          options: options,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisis Batard (${widget.option})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _numberControllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _numberControllers[index],
                            decoration: const InputDecoration(labelText: 'Nombre'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedTypes[index],
                          items: <String>['shot', 'gorgée', 'cul-sec'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedTypes[index] = newValue!;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            _removeOption(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addOption,
                child: const Text('Ajouter une option'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _startGame,
                child: const Text('Commencer le jeu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
