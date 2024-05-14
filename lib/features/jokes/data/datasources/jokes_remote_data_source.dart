import '../models/jokes_model.dart';

abstract class JokesRemoteDataSource {


  /// Calls the https://api.chucknorris.io/jokes/random endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getRandomJokes();

  /// Calls the https://api.chucknorris.io/jokes/random?category={category} endpoint.
  /// ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getRandomCategoryJokes(String category);

  /// Calls the https://api.chucknorris.io/jokes/search?query={query} endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getWithTextJokes(String textSearch);
}
