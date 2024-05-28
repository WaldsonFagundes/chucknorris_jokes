// Package imports:
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../../core/core_e.dart';
import '../../../domain/entities/entities_e.dart';
import '../../../domain/usecases/usecases_e.dart';
import 'joke_bloc_e.dart';

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
        final failureOrJoke =
            await getJokeByCategory(CategoryParams(category: event.category));
        await _eitherLoadedOrErrorState(failureOrJoke, emit);
      } else if (event is FetchJokeBySearch) {
        emit(JokeInitialState());
        emit(JokeLoading());
        final failureOrJoke =
            await getJokeBySearch(SearchParams(text: event.textSearch));
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
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    default:
      return 'Unexpected error';
  }
}
