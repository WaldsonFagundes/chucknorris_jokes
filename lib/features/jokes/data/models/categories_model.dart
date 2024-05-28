// Project imports:
import '../../domain/domain_e.dart';

class CategoriesModel extends Categories {
  CategoriesModel({required super.names});

  factory CategoriesModel.fromJson(List<dynamic> json) {
    return CategoriesModel(names: List<String>.from(json));
  }
}
