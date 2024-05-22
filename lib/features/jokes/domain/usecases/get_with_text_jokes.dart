import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/jokes.dart';
import '../repositories/jokes_repository.dart';

class GetWithTextJokes implements UseCase<Jokes, Params> {
  late JokesRepository repository;

  GetWithTextJokes(this.repository);

  @override
  Future<Either<Failure, Jokes>> call(Params params) async {
    return await repository.getWithTextJokes(params.text);
  }
}

class Params  extends Equatable{
  final String text;

  const Params({required this.text});

  @override
  List<Object?> get props => [text];
}
