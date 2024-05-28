// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';
import '../repositories/repositories_e.dart';

class GetJokeBySearch implements UseCase<Joke, SearchParams> {
  late JokeRepository repository;

  GetJokeBySearch(this.repository);

  @override
  Future<Either<Failure, Joke>> call(SearchParams params) async {
    return await repository.getJokeBySearch(params.text);
  }
}

class SearchParams extends Equatable {
  final String text;

  const SearchParams({required this.text});

  @override
  List<Object?> get props => [text];
}
