// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:chucknorris_jokes/features/jokes/data/models/joke_model.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testJokeModel = JokeModel(jokeText: 'Test text');

  test("Should be a subclass of NumberTrivia entity", () {
    expect(testJokeModel, isA<Joke>());
  });

  group('fromJson', () {
    test("Should return a valid model when the JSON value is a text", () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixtureReader('jokes_api_response.json'));

      final result = JokeModel.fromJson(jsonMap);

      expect(result, testJokeModel);
    });
  });

  group('toJson', () {
    test("Should return a JSON map containing the proper data", () {
      final result = testJokeModel.toJson();

      final expectMap = {"value": "Test text"};

      expect(result, expectMap);
    });
  });
}
