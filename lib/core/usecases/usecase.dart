// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
