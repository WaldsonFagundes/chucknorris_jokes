import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:dartz/dartz.dart';

class JokesRepositoryImpl implements JokesRepository{
  @override
  Future<Either<Failure, Jokes>> getRandomCategoryJokes(String category) {
    // TODO: implement getRandomCategoryJokes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Jokes>> getRandomJokes() {
    // TODO: implement getRandomJokes
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Jokes>> getWithTextJokes(String text) {
    // TODO: implement getWithTextJokes
    throw UnimplementedError();
  }
  
}