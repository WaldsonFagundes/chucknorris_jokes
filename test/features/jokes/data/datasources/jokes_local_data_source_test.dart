import 'dart:convert';

import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_local_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'jokes_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late JokesLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        JokesLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastJoke', () {
    final testJokesModel = JokesModel.fromJson(
        json.decode(fixtureReader('jokes_api_response.json')));

    test(
        "Should return Jokes from SharedPreferences when there is one in the cache",
        () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixtureReader('jokes_api_response.json'));

      final result = await dataSource.getLastJoke();

      verify(mockSharedPreferences.getString('CACHED_JOKES'));
      expect(result, equals(testJokesModel));
    });
    test("Should throw a CacheException when there is not a cached value",
        () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getLastJoke;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheJokes',(){
    const testJokesModel = JokesModel(jokeText: 'test text');

     test ("Should call SharedPreferences to cache the data", () async {
       dataSource.cacheJoke(testJokesModel);

       final expectedJsonString = json.encode(testJokesModel.toJson());

       verify(mockSharedPreferences.setString('CACHED_JOKES', expectedJsonString));

         });


  });
}
