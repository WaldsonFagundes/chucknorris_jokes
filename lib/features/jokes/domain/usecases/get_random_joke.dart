// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';
import '../repositories/repositories_e.dart';

class GetRandomJoke implements UseCase<Joke, RandomNoParams> {
  final JokeRepository repository;

  GetRandomJoke(this.repository);

  @override
  Future<Either<Failure, Joke>> call(RandomNoParams params) async {
    return await repository.getRandomJokes();
  }
}

class RandomNoParams {}
