import 'package:flutter/material.dart';
import 'package:joke_app/models/joke.dart';

class Choices extends StatefulWidget {
  const Choices({super.key});
  final ValueChanged<JokeType> jokeType;

  @override
  State<Choices> createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  JokeType? _selectedType;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: JokeType.values.map((type) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ChoiceChip(
            showCheckmark: false,
            label: Text(
              type.path,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            selectedColor: Colors.purple,
            selected: _selectedType == type,
            // backgroundColor: Colors.purple,
            onSelected: (bool selected) {
              setState(() {
                _selectedType = selected ? type : null;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
