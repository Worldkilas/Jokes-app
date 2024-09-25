import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joke_app/models/joke.dart';

import 'choices.dart';

class ContentContainer extends StatefulWidget {
  const ContentContainer({
    super.key,
    required this.size,
    required this.isLoading,
    required this.jokeContent,
    required this.selectedType,
  });

  final Size size;
  final bool isLoading;
  final String jokeContent;
  final JokeType selectedType;

  @override
  State<ContentContainer> createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
  //  void onTypeChanged(JokeType type) {
  //   setState(() {
  //     selectedType = type;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.65,
      width: widget.size.width,
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
          const SizedBox(
            height: 15,
          ),
          // Choices(onTypeChanged: onType,),
          widget.isLoading
              ? const CircularProgressIndicator()
              : Text(
                  widget.jokeContent,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cevicheOne(fontSize: 20),
                )
        ],
      ),
    );
  }
}
