import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/joke.dart';
import '../repositories/joke_repository.dart';

class GetJokeBySearch implements UseCase<Joke, SearchParams> {
  late JokeRepository repository;

  GetJokeBySearch(this.repository);

  @override
  Future<Either<Failure, Joke>> call(SearchParams params) async {
    return await repository.getJokeBySearch(params.text);
  }
}

class SearchParams  extends Equatable{
  final String text;

  const SearchParams({required this.text});

  @override
  List<Object?> get props => [text];
}
