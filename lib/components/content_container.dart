import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.size,
    required this.isLoading,
    required this.jokeContent,
  });

  final Size size;
  final bool isLoading;
  final String jokeContent;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(
            height: 15,
          ),
          isLoading
              ? const CircularProgressIndicator()
              : Text(
                  jokeContent,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cevicheOne(fontSize: 20),
                )
        ],
      ),
    );
  }
}
