import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class GetCategories implements UseCase<Categories, CategoriesNoParams> {

  final CategoriesRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, Categories>> call(CategoriesNoParams params) async {
    return await repository.getCategories();
  }

}

class CategoriesNoParams{}