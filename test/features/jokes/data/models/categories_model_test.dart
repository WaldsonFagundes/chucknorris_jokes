import 'dart:convert';

import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testCategoriesModel = CategoriesModel(names: [
    "animal",
    "career",
    "celebrity",
    "dev",
    "explicit",
    "fashion",
    "food",
    "history",
    "money",
    "movie",
    "music",
    "political",
    "religion",
    "science",
    "sport",
    "travel"
  ]);

  test("Should be a subclass of Categories entity", () {
    expect(testCategoriesModel, isA<Categories>());
  });

  test("Should return a valid model when the JSON is a list of categories", () {
    final jsonMap =
        json.decode(fixtureReader('jokes_api_response_categories.json'));

    final result = CategoriesModel.fromJson(jsonMap);

    expect(result, testCategoriesModel);
  });
}
