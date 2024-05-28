// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/core_e.dart';
import '../models/models_e.dart';

abstract class JokeRemoteDataSource {
  /// Calls the https://api.chucknorris.io/jokes/random endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokeModel> getRandomJoke();

  /// Calls the https://api.chucknorris.io/jokes/random?category={category} endpoint.
  /// ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
  /// Throws a [ServerExeception] for all error codes.
  Future<JokeModel> getJokesByCategory(String category);

  /// Calls the https://api.chucknorris.io/jokes/search?query={query} endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokeModel> getJokeBySearch(String textSearch);
}

class JokeRemoteDataSourceImpl implements JokeRemoteDataSource {
  final http.Client client;

  JokeRemoteDataSourceImpl({required this.client});

  @override
  Future<JokeModel> getJokesByCategory(String category) => _getJokeFromUrl(
      'https://api.chucknorris.io/jokes/random?category=$category');

  @override
  Future<JokeModel> getRandomJoke() =>
      _getJokeFromUrl('https://api.chucknorris.io/jokes/random');

  @override
  Future<JokeModel> getJokeBySearch(String textSearch) {
    return _getJokeFromUrl(
        'https://api.chucknorris.io/jokes/search?query=$textSearch');
  }

  Future<JokeModel> _getJokeFromUrl(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      if (url.contains('search')) {
        final jsonResponse = json.decode(response.body);
        final jokesList = jsonResponse['result'] as List;
        if (jokesList.isNotEmpty) {
          return JokeModel.fromJson(jokesList.first);
        } else {
          throw ServerException();
        }
      }

      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
