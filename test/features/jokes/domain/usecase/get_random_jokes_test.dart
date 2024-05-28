// Package imports:
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Project imports:
import 'package:chucknorris_jokes/features/jokes/domain/entities/joke.dart';
import 'package:chucknorris_jokes/features/jokes/domain/repositories/joke_repository.dart';
import 'package:chucknorris_jokes/features/jokes/domain/usecases/get_random_joke.dart';
import 'get_random_jokes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<JokeRepository>()])
void main() {
  late GetRandomJoke usecase;
  late MockJokeRepository mockJokesRepository;

  setUp(() {
    mockJokesRepository = MockJokeRepository();
    usecase = GetRandomJoke(mockJokesRepository);
  });

  const testJokes = Joke(jokeText: 'test_text');

  test("Should get joke from the repository", () async {
    when(mockJokesRepository.getRandomJokes())
        .thenAnswer((_) async => const Right(testJokes));

    final result = await usecase(RandomNoParams());

    expect(result, const Right(testJokes));
    verify(mockJokesRepository.getRandomJokes());
    verifyNoMoreInteractions(mockJokesRepository);
  });
}
