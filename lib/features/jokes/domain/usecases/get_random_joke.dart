import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/core/usecases/usecase.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomJoke implements UseCase<Joke, RandomNoParams> {
  final JokeRepository repository;

  GetRandomJoke(this.repository);

  @override
  Future<Either<Failure, Joke>> call(RandomNoParams params) async {
    return await repository.getRandomJokes();
  }
}

class RandomNoParams {}
