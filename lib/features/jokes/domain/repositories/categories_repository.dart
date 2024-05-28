// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, Categories>> getCategories();
}
