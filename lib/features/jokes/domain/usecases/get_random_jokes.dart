import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/core/usecases/usecase.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomJokes implements UseCase<Jokes, NoParamsRandom> {
  final JokesRepository repository;

  GetRandomJokes(this.repository);

  @override
  Future<Either<Failure, Jokes>> call(NoParamsRandom params) async {
    return await repository.getRandomJokes();
  }
}

class NoParamsRandom {}
