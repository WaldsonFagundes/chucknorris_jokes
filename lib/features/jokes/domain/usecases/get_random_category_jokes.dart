import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/jokes.dart';
import '../repositories/jokes_repository.dart';

class GetRandomCategoryJokes implements UseCase<Jokes, Params> {
  final JokesRepository repository;

  GetRandomCategoryJokes(this.repository);

  @override
  Future<Either<Failure, Jokes>> call(Params params) async {
    return await repository.getRandomCategoryJokes(params.category);
  }
}

class Params {
  final String category;

  const Params({required this.category});
}
