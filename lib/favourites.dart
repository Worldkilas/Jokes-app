import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

part 'favourites.g.dart';

@Collection()
class Favourites {
  late Id id;
  late String name;
  late DateTime dateCreated;
}

class FavouriteService {
  static late Isar isar;

  static Future<void> initializeDb() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([FavouritesSchema], directory: dir.path);
  }

  final List<Favourites> _favouriteJokes = [];

  // G E T T E R
  List<Favourites> get favouriteJokes => List.unmodifiable(_favouriteJokes);

  Future<void> addJoke({required String name, required int id}) async {
    final savedJoke = Favourites()
      ..name = name
      ..dateCreated = DateTime.now()
      ..id = id;

    await isar.writeTxn(() => isar.favourites.put(savedJoke));

    await readJokes();
  }

  Future<void> readJokes() async {
    List<Favourites> loadedJokes = await isar.favourites.where().findAll();

    _favouriteJokes.clear();

    _favouriteJokes.addAll(loadedJokes);
  }
}
