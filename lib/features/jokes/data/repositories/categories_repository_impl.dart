// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../../domain/domain_e.dart';
import '../datasources/datasources_e.dart';

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
