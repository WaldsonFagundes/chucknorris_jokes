import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:dartz/dartz.dart';

abstract class JokeRepository {

Future<Either<Failure, Joke>> getRandomJokes();
Future<Either<Failure, Joke>> getJokeByCategory(String category);
Future<Either<Failure, Joke>> getJokeBySearch(String text);

}