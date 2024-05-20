import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/jokes.dart';
import '../repositories/jokes_repository.dart';

class GetRandomCategoryJokes implements UseCase<Jokes, ParamsRandomCategory> {
  final JokesRepository repository;

  GetRandomCategoryJokes(this.repository);

  @override
  Future<Either<Failure, Jokes>> call(ParamsRandomCategory params) async {
    return await repository.getRandomCategoryJokes(params.category);
  }
}

class ParamsRandomCategory extends Equatable {
  final String category;

  const ParamsRandomCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
