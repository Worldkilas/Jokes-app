import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joke_app/components/box_container.dart';
import 'package:joke_app/models/joke.dart';
import '../components/my_drawer.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  JokeCategory selectedCategory = JokeCategory.any;
  JokeType selectedType = JokeType.single;
  bool isSafe = true;
  String jokeContent = '';
  JokeService? jokeService;

  Future<void> getJoke() async {
    final joke = await jokeService!.getJoke();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Random Jokes'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
              ))
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: size.height * 0.65,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/sad_emoji-removebg-preview.png',
                    ),
                    Text(jokeContent)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BoxContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star_border_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.copy_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              BoxContainer(
                child: Center(
                  child: Text(
                    "Generate Jokes",
                    style: GoogleFonts.cevicheOne(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
