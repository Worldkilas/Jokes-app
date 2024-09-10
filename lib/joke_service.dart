import 'models/joke.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JokeService {
  final Joke joke;

  Uri get url => Uri.parse(
      'https://v2.jokeapi.dev/joke/${joke.category.path}?type=${joke.type.path}&safe-mode=${joke.isSafe.toString()}');

  JokeService({required this.joke});

  Future<Joke> getJoke() async {
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw JokeRetrievalException(
          message: 'Failed to load joke',
          category: joke.category,
          type: joke.type);
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return Joke.fromJson(data);
  }
}

class JokeRetrievalException implements Exception {
  final String message;
  final JokeCategory category;
  final JokeType type;
  final int? statusCode;

  JokeRetrievalException({
    required this.message,
    required this.category,
    required this.type,
    this.statusCode,
  });

  @override
  String toString() {
    return 'JokeRetrievalException: $message. Category: ${category.path}, Type: ${type.path}, Status Code: ${statusCode ?? 'Unknown'}';
  }
}
