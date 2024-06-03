// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/core/core_e.dart';
import 'package:chucknorris_jokes/features/jokes/jokes_e.dart';
import 'get_random_joke_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late GetRandomJoke usecase;
  late MockJokeRepository mockJokesRepository;

  setUp(() {
    mockJokesRepository = MockJokeRepository();
    usecase = GetRandomJoke(mockJokesRepository);
  });

  const testJokes = Joke(jokeText: 'test text');

  test("Should get joke from the repository", () async {
    when(mockJokesRepository.getRandomJokes())
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(NoParams());

    expect(result, const Right(testJokes));
    verify(mockJokesRepository.getRandomJokes());
    verifyNoMoreInteractions(mockJokesRepository);
  });

  test("Should return server failure when repository call is unsuccessful",
      () async {
    when(mockJokesRepository.getRandomJokes())
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(ServerFailure()));
    verify(mockJokesRepository.getRandomJokes());
    verifyNoMoreInteractions(mockJokesRepository);
  });

  test("Should return cache failure when repository call is unsuccessful",
      () async {
    when(mockJokesRepository.getRandomJokes())
        .thenAnswer((_) async => Left(CacheFailure()));

    final result = await usecase(NoParams());

    expect(result, Left(CacheFailure()));
    verify(mockJokesRepository.getRandomJokes());
    verifyNoMoreInteractions(mockJokesRepository);
  });
}
