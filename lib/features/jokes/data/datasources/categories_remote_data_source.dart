// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/core_e.dart';
import '../models/models_e.dart';

abstract class CategoriesRemoteDataSource {
  /// Calls the https://api.chucknorris.io/jokes/categories endpoint.
  ///
  /// ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
  Future<CategoriesModel> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImpl({required this.client});

  @override
  Future<CategoriesModel> getCategories() async {
    final response = await client.get(
        Uri.parse("https://api.chucknorris.io/jokes/categories"),
        headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
