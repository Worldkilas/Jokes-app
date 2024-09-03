import 'package:flutter/material.dart';
import 'package:joke_app/models/joke.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.onCategorySelected});
  final ValueChanged<JokeCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(' Select a category'),
          ),
          ...JokeCategory.values.map((category) => ListTile(
                title: Text(category.path),
                onTap: () {
                  Navigator.pop(context);
                  onCategorySelected(category);
                },
              ))
        ],
      ),
      // child: DrawerHeader(child: child),
    );
  }
}
