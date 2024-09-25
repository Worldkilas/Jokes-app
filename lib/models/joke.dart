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
  final String? setup;
  final String? delivery;
  final String jokeContent;
  final JokeType type;
  final int id;
  final bool isSafe;
  final String? errorMessage;

  Joke(
      {required this.category,
      required this.jokeContent,
      required this.type,
      required this.isSafe,
      required this.errorMessage,
      this.setup,
      this.delivery,
      required this.id});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      errorMessage: json['error'] == true ? json['message'] : null,
      setup: json['type'] == 'twopart' ? json['setup'] as String? : null,
      delivery: json['type'] == 'twopart' ? json['delivery'] as String? : null,
      category: JokeCategory.parseFromString(json['category']),
      jokeContent: json['type'] == 'single'
          ? json['joke'] as String
          : {"${json['setup']} ${json['delivery']}"} as String,
      isSafe: json['safe'] as bool,
      id: json['id'] as int,
      type: JokeType.parseFromString(
        json['type'],
      ),
    );
  }
}
