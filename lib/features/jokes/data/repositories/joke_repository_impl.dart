// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../../domain/domain_e.dart';
import '../datasources/datasources_e.dart';
import '../models/models_e.dart';

typedef _TypesOfGetJokes = Future<Joke> Function();

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
    return await _getJokes(() => remoteDataSource.getJokesByCategory(category));
  }

  @override
  Future<Either<Failure, Joke>> getRandomJokes() async {
    return await _getJokes(() => remoteDataSource.getRandomJoke());
  }

  @override
  Future<Either<Failure, Joke>> getJokeBySearch(String text) async {
    return await _getJokes(() => remoteDataSource.getJokeBySearch(text));
  }

  Future<Either<Failure, Joke>> _getJokes(
      _TypesOfGetJokes getTypesOfMethods) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJokes = await getTypesOfMethods();
        localDataSource.cacheJoke(remoteJokes as JokeModel);
        return Right(remoteJokes);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastJoke();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
