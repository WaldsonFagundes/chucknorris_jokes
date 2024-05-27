import 'package:bloc/bloc.dart';
import 'package:chucknorris_jokes/core/error/failures.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_categories.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_joke_by_search.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/joke.dart';
import '../../../domain/usecases/get_joke_by_category.dart';
import 'joke_event.dart';
import 'joke_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_CATEGORY_FAILURE_MESSAGE = 'Invalid category';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetJokeByCategory getJokeByCategory;
  final GetJokeBySearch getJokeBySearch;
  final GetRandomJoke getRandomJoke;

  JokeBloc({
    required this.getJokeByCategory,
    required this.getJokeBySearch,
    required this.getRandomJoke,
  }) : super(JokeInitialState()) {

    on<JokeEvent>((event, emit) async {

      if (event is FetchJokeByCategory) {
        emit(JokeInitialState());
        emit(JokeLoading());
        final failureOrJoke = await getJokeByCategory(
            CategoryParams(category: event.category));
        await _eitherLoadedOrErrorState(failureOrJoke, emit);

      } else if (event is FetchJokeBySearch) {
        emit(JokeInitialState());
        emit(JokeLoading());
        final failureOrJoke = await getJokeBySearch(SearchParams(text: event.textSearch));
        await _eitherLoadedOrErrorState(failureOrJoke, emit);

      } else if (event is FetchRandomJoke) {
        emit(JokeInitialState());
        emit(JokeLoading());
        final failureOrJoke = await getRandomJoke(RandomNoParams());
        await _eitherLoadedOrErrorState(failureOrJoke, emit);

      }
    });
  }
}

Future<void> _eitherLoadedOrErrorState(
    Either<Failure, Joke> failureOrJoke, Emitter<JokeState> emit) async {
  emit(failureOrJoke.fold(
      (failure) => JokeError(message: _mapFailureToMessage(failure)),
      (joke) => JokeLoaded(jokes: joke)));
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
