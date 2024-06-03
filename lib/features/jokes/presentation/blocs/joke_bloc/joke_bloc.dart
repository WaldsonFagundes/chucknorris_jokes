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
    on<FetchJokeByCategory>(_onFetchJokeByCategory);
    on<FetchJokeBySearch>(_onFetchJokeBySearch);
    on<FetchRandomJoke>(_onFetchRandomJoke);
  }

  Future<void> _onFetchJokeByCategory(
      FetchJokeByCategory event, Emitter<JokeState> emit) async {
    emit(JokeLoading());
    final failureOrJoke =
        await getJokeByCategory(CategoryParams(category: event.category));
    emit(_mapFailureOrJokeToState(failureOrJoke));
  }

  Future<void> _onFetchJokeBySearch(
      FetchJokeBySearch event, Emitter<JokeState> emit) async {
    emit(JokeLoading());
    final failureOrJoke =
        await getJokeBySearch(SearchParams(text: event.textSearch));
    emit(_mapFailureOrJokeToState(failureOrJoke));
  }

  Future<void> _onFetchRandomJoke(
      FetchRandomJoke event, Emitter<JokeState> emit) async {
    emit(JokeLoading());
    final failureOrJoke = await getRandomJoke(NoParams());
    emit(_mapFailureOrJokeToState(failureOrJoke));
  }

  JokeState _mapFailureOrJokeToState(Either<Failure, Joke> failureOrJoke) {
    return failureOrJoke.fold(
      (failure) => JokeError(message: _mapFailureToMessage(failure)),
      (joke) => JokeLoaded(jokes: joke),
    );
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
}
