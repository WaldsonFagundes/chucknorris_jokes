// Package imports:
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import '../../../../core/core_e.dart';
import '../entities/entities_e.dart';
import '../repositories/repositories_e.dart';

class GetJokeByCategory implements UseCase<Joke, CategoryParams> {
  final JokeRepository repository;

  GetJokeByCategory(this.repository);

  @override
  Future<Either<Failure, Joke>> call(CategoryParams params) async {
    return await repository.getJokeByCategory(params.category);
  }
}

class CategoryParams extends Equatable {
  final String category;

  const CategoryParams({required this.category});

  @override
  List<Object?> get props => [category];
}
