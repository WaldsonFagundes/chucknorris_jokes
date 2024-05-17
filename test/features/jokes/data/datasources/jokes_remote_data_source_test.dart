import 'dart:convert';

import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'jokes_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late JokesRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = JokesRemoteDataSourceImpl(client: mockHttpClient);
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
    final testJokesModel = JokesModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
        () async {
      setUpMockHttpClientSuccess200();

      await dataSource.getRandomCategoryJokes(testTextCategory);

      verify(mockHttpClient.get(
          Uri.parse(
              'https://api.chucknorris.io/jokes/random?category=$testTextCategory'),
          headers: {
            'Content-Type': 'application/json',
          }));
    });

    test("Should return Jokes when the response code is 200", () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomCategoryJokes(testTextCategory);

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
        () async {
      setUpMockHttpClient404();

      final call = dataSource.getRandomCategoryJokes;

      expect(() => call(testTextCategory),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });


  group('getWithTextJokes', () {
    const testTextSearch = 'anything';
    final testJokesModel = JokesModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
            () async {
          setUpMockHttpClientSuccess200();

          await dataSource.getWithTextJokes(testTextSearch);

          verify(mockHttpClient.get(
              Uri.parse(
                  'https://api.chucknorris.io/jokes/search?query=$testTextSearch'),
              headers: {
                'Content-Type': 'application/json',
              }));
        });

    test("Should return Jokes when the response code is 200", () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getWithTextJokes(testTextSearch);

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
            () async {
          setUpMockHttpClient404();

          final call = dataSource.getWithTextJokes;

          expect(() => call(testTextSearch),
              throwsA(const TypeMatcher<ServerException>()));
        });
  });

  group('getRandomJokes', () {
    final testJokesModel = JokesModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should perform a Get request on a URL with textCategory being the endpoint and with application/json header",
            () async {
          setUpMockHttpClientSuccess200();

          await dataSource.getRandomJokes();

          verify(mockHttpClient.get(
              Uri.parse(
                  'https://api.chucknorris.io/jokes/random'),
              headers: {
                'Content-Type': 'application/json',
              }));
        });

    test("Should return Jokes when the response code is 200", () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomJokes();

      expect(result, equals(testJokesModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
            () async {
          setUpMockHttpClient404();

          final call = dataSource.getRandomJokes;

          expect(() => call(),
              throwsA(const TypeMatcher<ServerException>()));
        });
  });

}
