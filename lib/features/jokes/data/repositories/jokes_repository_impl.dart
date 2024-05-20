import 'package:chucknorris_jokes/core/error/execeptions.dart';
import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_local_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/jokes_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/jokes_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../models/jokes_model.dart';

typedef _TypesOfGetJokes = Future<Jokes> Function();

class JokesRepositoryImpl implements JokesRepository {
  final JokesRemoteDataSource remoteDataSource;
  final JokesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  JokesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Jokes>> getRandomCategoryJokes(String category) async {
    return await _getJokes(
        () => remoteDataSource.getRandomCategoryJokes(category));
  }

  @override
  Future<Either<Failure, Jokes>> getRandomJokes() async {
    return await _getJokes(() => remoteDataSource.getRandomJokes());
  }

  @override
  Future<Either<Failure, Jokes>> getWithTextJokes(String text) async {
    return await _getJokes(() => remoteDataSource.getWithTextJokes(text));
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      return Right(await remoteDataSource.getCategories());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Jokes>> _getJokes(
      _TypesOfGetJokes getTypesOfMethods) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJokes = await getTypesOfMethods();
        localDataSource.cacheJoke(remoteJokes as JokesModel);
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
