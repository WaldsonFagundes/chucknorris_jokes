// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/error/exceptions.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/joke_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/joke_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'jokes_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late JokeRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = JokeRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response(fixtureReader('jokes_api_response.json'), 200));
  }

  void setUpMockHttpClient404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getRandomCategoryJokes', () {
    const testTextCategory = 'test category';
    final testJokesModel = JokeModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
        () async {
      setUpMockHttpClientSuccess200();

      await dataSource.getJokesByCategory(testTextCategory);

      verify(mockHttpClient.get(
          Uri.parse(
              'https://api.chucknorris.io/jokes/random?category=$testTextCategory'),
          headers: {
            'Content-Type': 'application/json',
          }));
    });

    test("Should return Jokes when the response code is 200", () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getJokesByCategory(testTextCategory);

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
        () async {
      setUpMockHttpClient404();

      final call = dataSource.getJokesByCategory;

      expect(() => call(testTextCategory),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getWithTextJokes', () {
    const testTextSearch = 'anything';
    final testJokesModel = JokeModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
              fixtureReader('jokes_api_response_search.json'), 200));

      await dataSource.getJokeBySearch(testTextSearch);

      verify(mockHttpClient.get(
          Uri.parse(
              'https://api.chucknorris.io/jokes/search?query=$testTextSearch'),
          headers: {
            'Content-Type': 'application/json',
          }));
    });

    test("Should return Jokes when the response code is 200", () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
              fixtureReader('jokes_api_response_search.json'), 200));

      final result = await dataSource.getJokeBySearch(testTextSearch);

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
        () async {
      setUpMockHttpClient404();

      final call = dataSource.getJokeBySearch;

      expect(() => call(testTextSearch),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomJokes', () {
    final testJokesModel = JokeModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
        () async {
      setUpMockHttpClientSuccess200();

      await dataSource.getRandomJoke();

      verify(mockHttpClient
          .get(Uri.parse('https://api.chucknorris.io/jokes/random'), headers: {
        'Content-Type': 'application/json',
      }));
    });

    test("Should return Jokes when the response code is 200", () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomJoke();

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
        () async {
      setUpMockHttpClient404();

      final call = dataSource.getRandomJoke;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
