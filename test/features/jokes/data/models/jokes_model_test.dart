import 'dart:convert';

import 'package:chucknorris_jokes/features/jokes/data/models/jokes_model.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testJokesModel = JokesModel(jokeText: 'Test text');

  test("Should be a subclass of NumberTrivia entity", () {
    expect(testJokesModel, isA<Jokes>());
  });

  group('fromJson', () {
    test("Should return a valid model when the JSON value is a text", () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixtureReader('jokes_api_response.json'));

      final result = JokesModel.fromJson(jsonMap);

      expect(result, testJokesModel);
    });
  });

  group('toJson', () {
    test("Should return a JSON map containing the proper data", () {
      final result = testJokesModel.toJson();

      final expectMap = {"value": "Test text"};

      expect(result, expectMap);
    });
  });
}
