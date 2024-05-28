// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';

abstract class JokeRepository {
  Future<Either<Failure, Joke>> getRandomJokes();
  Future<Either<Failure, Joke>> getJokeByCategory(String category);
  Future<Either<Failure, Joke>> getJokeBySearch(String text);
}
