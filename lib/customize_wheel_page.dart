import 'package:flutter/material.dart';
import 'roulette_game.dart';

class CustomizeWheelPage extends StatefulWidget {
  @override
  _CustomizeWheelPageState createState() => _CustomizeWheelPageState();
}

class _CustomizeWheelPageState extends State<CustomizeWheelPage> {
  final List<TextEditingController> _controllers = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _addOption();
    _addOption();
  }

  void _addOption() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    setState(() {
      _controllers.removeAt(index);
    });
  }

  void _startRoulette() {
    if (_formKey.currentState!.validate()) {
      List<String> options = _controllers.map((controller) => controller.text).toList();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RouletteGame(
            option: 'custom',
            options: options,
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiens tiens retiens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _controllers[index],
                            decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer une option';
                              }
                              return null;
                            },
                          ),
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
                onPressed: _startRoulette,
                child: const Text('Commencer le jeu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
