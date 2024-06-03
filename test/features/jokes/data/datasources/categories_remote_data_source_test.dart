// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/data/data_e.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'categories_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late CategoriesRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = CategoriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(
            fixtureReader('jokes_api_response_categories.json'), 200));
  }

  void setUpMockHttpClient404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Something went wrong', 404));
  }

  final testCategoriesModel = CategoriesModel.fromJson(
      json.decode(fixtureReader('jokes_api_response_categories.json')));

  Uri uriParse = Uri.parse('https://api.chucknorris.io/jokes/categories');
  Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  test("Should return Categories when the response is code 200", () async {
    setUpMockHttpClientSuccess200();

    final result = await dataSource.getCategories();

    expect(result, equals(testCategoriesModel));
  });

  test(
      "Should perform a Get request on a URL  and with application/json header",
      () async {
    setUpMockHttpClientSuccess200();

    await dataSource.getCategories();

    verify(mockHttpClient.get(uriParse, headers: header));
  });


  test("Should throw a ServerException when the response code is 404 or other", () async {
    setUpMockHttpClient404();

    final call = dataSource.getCategories;

    expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
  });

}
