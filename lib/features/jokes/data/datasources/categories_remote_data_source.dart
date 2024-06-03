// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../../../../core/core_e.dart';
import '../models/models_e.dart';

abstract class CategoriesRemoteDataSource {
  /// Calls the https://api.chucknorris.io/jokes/categories endpoint.
  /// Returns a [CategoriesModel] containing the list of categories./
  /// ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
  Future<CategoriesModel> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImpl({required this.client});

  static const String _baseUrl = 'https://api.chucknorris.io/jokes';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  @override
  Future<CategoriesModel> getCategories() async {
    final response =
        await client.get(Uri.parse("$_baseUrl/categories"), headers: _headers);
    if (response.statusCode == 200) {
      return CategoriesModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
