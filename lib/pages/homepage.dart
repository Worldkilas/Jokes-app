import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joke_app/components/box_container.dart';
import 'package:joke_app/models/joke.dart';
import '../components/content_container.dart';
import '../components/my_drawer.dart';

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
  String? errorMessage;
  int id = 0;

  bool isLoading = false;

  Future<void> getJoke() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final jokeParameters = Joke(
        category: selectedCategory,
        jokeContent: jokeContent,
        type: selectedType,
        isSafe: isSafe,
        id: id,
      );
      JokeService jokeService = JokeService(joke: jokeParameters);
      final fetchedJoke = await jokeService.getJoke();
      setState(() {
        jokeContent = fetchedJoke.jokeContent;
      });
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onCategorySelected(JokeCategory jokeCategory) {
    setState(() {
      selectedCategory = jokeCategory;
    });
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
      drawer: MyDrawer(
        onCategorySelected: onCategorySelected,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ContentContainer(
                size: size,
                isLoading: isLoading,
                jokeContent: jokeContent,
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
              Material(
                child: InkWell(
                  onTap: getJoke,
                  child: BoxContainer(
                    child: Center(
                      child: Text(
                        "Generate Jokes",
                        style: GoogleFonts.cevicheOne(fontSize: 20),
                      ),
                    ),
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
