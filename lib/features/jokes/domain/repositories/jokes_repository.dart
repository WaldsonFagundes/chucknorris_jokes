import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:dartz/dartz.dart';

abstract class JokesRepository {

Future<Either<Failure, List<String>>> getCategories();
Future<Either<Failure, Jokes>> getRandomJokes();
Future<Either<Failure, Jokes>> getRandomCategoryJokes(String category);
Future<Either<Failure, Jokes>> getWithTextJokes(String text);

}