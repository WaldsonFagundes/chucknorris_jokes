import 'package:chucknorris_jokes/features/jokes/domain/entities/categories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, Categories>> getCategories();
}