import 'dart:convert';

import 'package:http/http.dart' as http;

enum JokeType {
  single('single'),
  twoPart('twopart');

  final String path;
  const JokeType(this.path);

  static JokeType parseFromString(String type) {
    switch (type.toLowerCase()) {
      case 'single':
        return JokeType.single;
      case 'twopart':
        return JokeType.twoPart;

      default:
        throw Exception('Unknown joke type');
    }
  }
}

enum JokeCategory {
  any('Any'),
  misc('Misc'),
  programming('Programming'),
  dark('Dark'),
  pun('Pun'),
  spooky('Spooky'),
  christmas('Christmas');

  final String path;

  const JokeCategory(this.path);

  static JokeCategory parseFromString(String category) {
    return switch (category.toLowerCase()) {
      'misc' => JokeCategory.misc,
      'any' => JokeCategory.any,
      'dark' => JokeCategory.dark,
      'pun' => JokeCategory.pun,
      'spooky' => JokeCategory.spooky,
      'christmas' => JokeCategory.christmas,
      _ => throw ArgumentError('Invalid joke category: $category')
    };
  }
}

class Joke {
  final JokeCategory category;
  final String jokeContent;
  final JokeType type;
  final int id;
  final bool isSafe;

  Joke(
      {required this.category,
      required this.jokeContent,
      required this.type,
      required this.isSafe,
      required this.id});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
        category: JokeCategory.parseFromString(json['category']),
        jokeContent: json['type'] == 'single'
            ? json['joke']
            : {"${json['setup']} ${json['delivery']}"} as String,
        isSafe: json['safe'] as bool,
        id: json['id'] as int,
        type: JokeType.parseFromString(json['type']));
  }
}

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
