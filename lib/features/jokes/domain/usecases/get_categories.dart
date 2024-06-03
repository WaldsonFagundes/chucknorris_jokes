// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';
import '../repositories/repositories_e.dart';

class GetCategories implements UseCase<Categories, NoParams> {
  final CategoriesRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, Categories>> call(NoParams noParams) async {
    return await repository.getCategories();
  }
}


