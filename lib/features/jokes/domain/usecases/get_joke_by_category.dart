import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/joke.dart';
import '../repositories/joke_repository.dart';

class GetJokeByCategory implements UseCase<Joke, CategoryParams> {
  final JokeRepository repository;

  GetJokeByCategory(this.repository);

  @override
  Future<Either<Failure, Joke>> call(CategoryParams params) async {
    return await repository.getJokeByCategory(params.category);
  }
}

class CategoryParams extends Equatable {
  final String category;

  const CategoryParams({required this.category});

  @override
  List<Object?> get props => [category];
}
