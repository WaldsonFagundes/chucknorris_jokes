import 'package:bloc/bloc.dart';
import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_with_text_jokes.dart';
import 'package:chucknorris_jokes/features/jokes/presentation/bloc/jokes_event.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/jokes.dart';
import '../../domain/usecases/get_random_category_jokes.dart';
import 'jokes_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_CATEGORY_FAILURE_MESSAGE = 'Invalid category';

class JokesBloc extends Bloc<JokesEvent, JokeState> {
  final GetRandomCategoryJokes getRandomCategoryJokes;
  final GetWithTextJokes getWithTextJokes;
  final GetRandomJokes getRandomJokes;
  final GetCategories getCategories;

  JokesBloc({
    required this.getRandomCategoryJokes,
    required this.getWithTextJokes,
    required this.getRandomJokes,
    required this.getCategories,
  }) : super(Empty()) {
    on<JokesEvent>((event, emit) async {
      if (event is GetJokeForCategory) {
        emit(Empty());
        emit(Loading());
        final failureOrJoke =
        await getRandomCategoryJokes(ParamsRandomCategory(category: event.category));
        await _eitherLoadedOrErrorState(failureOrJoke, emit);
      }
    });
  }
}

Future<void> _eitherLoadedOrErrorState(Either<Failure, Jokes> failureOrJoke,
    Emitter<JokeState> emit) async {
  emit(failureOrJoke.fold((failure) =>
      Error(message: _mapFailureToMessage(failure)), (joke) => Loaded(jokes: joke)));
}


String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
