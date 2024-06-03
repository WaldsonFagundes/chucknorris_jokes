// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../../domain/domain_e.dart';
import '../datasources/datasources_e.dart';
import '../models/models_e.dart';

typedef _GetJokeFunction = Future<Joke> Function();

class JokeRepositoryImpl implements JokeRepository {
  final JokeRemoteDataSource remoteDataSource;
  final JokeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  JokeRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Joke>> getJokeByCategory(String category) async {
    return await _getJoke(() => remoteDataSource.getJokesByCategory(category));
  }

  @override
  Future<Either<Failure, Joke>> getRandomJokes() async {
    return await _getJoke(() => remoteDataSource.getRandomJoke());
  }

  @override
  Future<Either<Failure, Joke>> getJokeBySearch(String text) async {
    return await _getJoke(() => remoteDataSource.getJokeBySearch(text));
  }

  Future<Either<Failure, Joke>> _getJoke(
      _GetJokeFunction getJokeFunction) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJoke = await getJokeFunction();
        localDataSource.cacheJoke(remoteJoke as JokeModel);
        return Right(remoteJoke);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localJoke = await localDataSource.getLastJoke();
        return Right(localJoke);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
