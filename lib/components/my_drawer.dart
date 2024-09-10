import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          DrawerHeader(
            child: Text(
              'Select a category',
              style: GoogleFonts.cevicheOne(fontSize: 20),
            ),
          ),
          ...JokeCategory.values.map((category) => ListTile(
                contentPadding: const EdgeInsets.only(left: 20),
                title: Text(
                  category.path,
                  style: GoogleFonts.cevicheOne(fontSize: 20),
                ),
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
