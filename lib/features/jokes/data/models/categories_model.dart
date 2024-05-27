import 'package:chucknorris_jokes/features/jokes/domain/entities/categories.dart';

class CategoriesModel extends Categories {

  CategoriesModel({required super.names});

  factory CategoriesModel.fromJson(List<dynamic> json) {
    return CategoriesModel(names: List<String>.from(json));
  }

}