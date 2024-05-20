import 'dart:convert';

import 'package:chucknorris_jokes/core/error/execeptions.dart';

import '../models/jokes_model.dart';
import 'package:http/http.dart' as http;

abstract class JokesRemoteDataSource {
  /// Calls the https://api.chucknorris.io/jokes/random endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getRandomJokes();

  Future<List<String>> getCategories();

  /// Calls the https://api.chucknorris.io/jokes/random?category={category} endpoint.
  /// ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getRandomCategoryJokes(String category);

  /// Calls the https://api.chucknorris.io/jokes/search?query={query} endpoint.
  ///
  /// Throws a [ServerExeception] for all error codes.
  Future<JokesModel> getWithTextJokes(String textSearch);
}

class JokesRemoteDataSourceImpl implements JokesRemoteDataSource {
  final http.Client client;

  JokesRemoteDataSourceImpl({required this.client});

  @override
  Future<JokesModel> getRandomCategoryJokes(String category) =>
      _getJokesFromUrl(
          'https://api.chucknorris.io/jokes/random?category=$category');

  @override
  Future<JokesModel> getRandomJokes() =>
      _getJokesFromUrl('https://api.chucknorris.io/jokes/random');

  @override
  Future<JokesModel> getWithTextJokes(String textSearch) => _getJokesFromUrl(
      'https://api.chucknorris.io/jokes/search?query=$textSearch');

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(
        Uri.parse("https://api.chucknorris.io/jokes/categories"),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      final List<String> listCategories = json.decode(response.body);

      return listCategories;
    } else {
      throw ServerException();
    }
  }

  Future<JokesModel> _getJokesFromUrl(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return JokesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
