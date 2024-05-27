import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/data/datasources/categories_remote_data_source.dart';
import 'package:chucknorris_jokes/features/jokes/domain/entities/categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/execeptions.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Categories>> getCategories() async {
    try {
      return Right(await remoteDataSource.getCategories());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
